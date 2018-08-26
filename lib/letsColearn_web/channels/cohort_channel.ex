defmodule LetsColearnWeb.CohortChannel do
    use Phoenix.Channel

    alias LetsColearn.Cohorts
    alias LetsColearn.Cohorts.Chat
    require IEx

    # Do authorization
    def join("cohort:" <> cohort_id, _message, socket) do
        user = Guardian.Phoenix.Socket.current_resource(socket)
        case authorize(user, cohort_id) do
            {:ok} -> {:ok, Guardian.Phoenix.Socket.put_current_claims(socket, %{"cohort_id" => cohort_id})}
            {:error} -> {:error, {:reason, "You need to join group"}}
        end
    end

    def handle_in("new_msg", %{"message" => msg} = payload, socket) do
        user = Guardian.Phoenix.Socket.current_resource(socket)
        cohort_id = Guardian.Phoenix.Socket.current_claims(socket)["cohort_id"]

        payload
        |> Map.put("user_id", user.id)
        |> Map.put("cohort_id", cohort_id)
        |> Cohorts.create_chat

        broadcast! socket, "new_msg", %{message: msg, name: user.username}
        {:noreply, socket}
    end

    def authorize(user, cohort_id)do
        cohort = Cohorts.get_cohort!(cohort_id)
        if Enum.any?(cohort.users, &(&1.id == user.id)) do
            {:ok}
        else
            {:error}
        end
    end
end
defmodule LetsColearnWeb.CohortChannel do
    use Phoenix.Channel

    alias LetsColearn.Cohorts
    alias LetsColearn.Cohorts.Chat
    alias LetsColearn.Accounts.Auth


    # Do authorization
    def join("cohort:" <> cohort_id, _message, socket) do
        user = Guardian.Phoenix.Socket.current_resource(socket)
        case Auth.authorize(user, cohort_id) do
            {:ok} -> 
                send(self(), {:after_join, {cohort_id, user}})
                {:ok, Guardian.Phoenix.Socket.put_current_claims(socket, %{"cohort_id" => cohort_id})}
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

    def handle_info({:after_join, {cohort_id, user}}, socket) do
        Cohorts.list_chat_in_cohort(cohort_id)
        |> Enum.reverse
        |> Enum.each(fn msg -> push(socket, "new_msg", %{
            name: user.username,
            message: msg.message
        }) end)
        {:noreply, socket}
    end


end
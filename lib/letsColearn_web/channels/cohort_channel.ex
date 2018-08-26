defmodule LetsColearnWeb.CohortChannel do
    use Phoenix.Channel

    # Do authorization
    def join("cohort:" <> cohort_id, _message, socket) do
        user = Guardian.Phoenix.Socket.current_resource(socket)
        IO.inspect(cohort_id)
        case authorize(user, cohort_id) do
            {:ok} -> {:ok, socket}
            {:error} -> {:error, {:reason, "You need to join group"}}
        end
    end

    def handle_in("new_msg", %{"message" => msg}, socket) do
        user = Guardian.Phoenix.Socket.current_resource(socket)
        broadcast! socket, "new_msg", %{message: msg, name: user.username}
        {:noreply, socket}
    end

    def authorize(user, cohort_id)do
        # authorize from database
        {:ok}
    end
end
defmodule LetsColearnWeb.CohortChannel do
    use Phoenix.Channel

    # Do authorization
    def join("cohort:lobby", _message, socket) do
        {:ok, socket}
    end

    def handle_in("new_msg", %{"message" => msg}, socket) do
        user = Guardian.Phoenix.Socket.current_resource(socket)
        broadcast! socket, "new_msg", %{message: msg, name: user.username}
        {:noreply, socket}
    end
end
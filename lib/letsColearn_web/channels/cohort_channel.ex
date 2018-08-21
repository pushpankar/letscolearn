defmodule LetsColearnWeb.CohortChannel do
    use Phoenix.Channel

    # Do authorization
    def join("room:" <> cohort_id, _message, socket) do
        {:ok, socket}
    end

    def handle_in("new_msg", %{"body" => body}, socket) do
        broadcast! socket, "new_msg", %{body: body}
        {:noreply, socket}
    end
end
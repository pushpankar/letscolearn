defmodule LetsColearn.AuthErrorHandler do
    import Plug.Conn
    import LetsColearnWeb.Router.Helpers
  
    def auth_error(conn, {type, _reason}, _opts) do
        conn
        |> Phoenix.Controller.put_flash(:error, "You must be logged in to access that page.")
        |> Phoenix.Controller.redirect(to: session_path(conn, :new))
    end
  end
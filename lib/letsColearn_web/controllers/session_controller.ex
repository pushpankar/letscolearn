defmodule LetsColearnWeb.SessionController do
    use LetsColearnWeb, :controller

    alias LetsColearn.Accounts
    alias LetsColearn.Accounts.User
    alias LetsColearn.Guardian
    alias LetsColearn.Accounts.Auth
    require Logger
  
    def new(conn, _) do
        changeset = Accounts.change_user(%User{})
        maybe_user = Guardian.Plug.current_resource(conn)
        IO.inspect(maybe_user)
        if maybe_user do
            redirect(conn, to: "/users")
        else
            render(conn, "new.html", changeset: changeset)
        end
    end
  
  
    def create(conn, params) do
      Auth.authenticate(params)
      |> login_reply(conn)
    end
  
    def delete(conn, _) do
      conn
      |> Guardian.Plug.sign_out()
      |> redirect(to: "/login")
    end
  
    defp login_reply({:ok, user}, conn) do
      conn
      |> put_flash(:success, "Welcome back!")
      |> Guardian.Plug.sign_in(user)
      |> redirect(to: "/users")
    end
  
    defp login_reply({:error, reason}, conn) do
      conn
      |> put_flash(:error, to_string(reason))
      |> new(%{})
    end
  end
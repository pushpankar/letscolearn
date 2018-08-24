defmodule LetsColearn.SessionController do
    use LetsColearnWeb, :controller

    alias LetsColearn.Accounts
    alias LetsColearn.Accounts.User
    alias LetsColearn.Guardian
    alias LetsColearn.Accounts.Auth
  
    def new(conn, _) do
        changeset = Accounts.change_user(%User{})
        maybe_user = Guardian.Plug.current_resource(conn)
        if maybe_user do
            redirect(conn, to: "/users")
        else
            render(conn, "new.html", changeset: changeset)
        end
    end
  
  
    def login(conn, params) do
      Auth.authenticate_user(params)
      |> login_reply(conn)
    end
  
    def logout(conn, _) do
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
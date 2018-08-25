defmodule LetsColearnWeb.LayoutView do
  use LetsColearnWeb, :view

  alias LetsColearn.Guardian

  def login_or_logout(conn) do
    maybe_user = Guardian.Plug.current_resource(conn)
    if maybe_user do
      render "logout.html", conn: conn
    else
      render "login.html", conn: conn
    end

  end
end

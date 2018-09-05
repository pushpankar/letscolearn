defmodule LetsColearnWeb.HomeController do
  use LetsColearnWeb, :controller

  alias LetsColearn.Guardian
  alias LetsColearn.Aim

  def index(conn, _params) do
    if Guardian.Plug.current_resource(conn) do
      redirect(conn, to: home_path(conn, :my))
    else
      redirect(conn, to: goal_path(conn, :index))
    end
  end

  def my(conn, _params) do
    maybe_user = Guardian.Plug.current_resource(conn)
    if maybe_user do
      goals = Aim.user_goals(maybe_user)
      render(conn, "index.html", goals: goals)
    else
      redirect(conn, to: session_path(conn, :new))
    end
  end

end
defmodule LetsColearnWeb.HomeController do
  use LetsColearnWeb, :controller

  alias LetsColearn.Guardian
  alias LetsColearn.Repo
  alias LetsColearn.Cohorts

  def index(conn, _params) do
    cohorts = Cohorts.list_cohorts()

    maybe_user = Guardian.Plug.current_resource(conn)
    if maybe_user do
      user_cohorts = Repo.preload(maybe_user, :cohorts).cohorts
      render conn, "index.html", user_cohorts: user_cohorts, cohorts: cohorts
    else
      render conn, "index.html", cohorts: cohorts
    end

  end
end


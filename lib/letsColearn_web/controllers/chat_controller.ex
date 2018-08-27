defmodule LetsColearnWeb.ChatController do
  use LetsColearnWeb, :controller

  alias LetsColearn.Cohorts
  alias LetsColearn.Cohorts.Chat
  alias LetsColearn.Accounts.Auth

  # Authentication is being done in socket
  def index(conn, %{"cohort_id" => id}) do
    if Auth.has_joined?(%{"conn" => conn, "cohort_id" => id}) do
      cohort = Cohorts.get_cohort!(id)
      render(conn, "index.html", cohort: cohort)
    else
      redirect(conn, to: "/")
    end
  end
end
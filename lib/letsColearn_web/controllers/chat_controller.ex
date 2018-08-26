defmodule LetsColearnWeb.ChatController do
  use LetsColearnWeb, :controller

  alias LetsColearn.Cohorts
  alias LetsColearn.Cohorts.Chat

  def index(conn, %{"cohort_id" => id}) do
    render(conn, "index.html")
  end
end
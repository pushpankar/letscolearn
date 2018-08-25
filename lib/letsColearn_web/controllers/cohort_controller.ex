defmodule LetsColearnWeb.CohortController do
  use LetsColearnWeb, :controller

  alias LetsColearn.Cohorts
  alias LetsColearn.Cohorts.Cohort

  def index(conn, _params) do
    cohorts = Cohorts.list_cohorts()
    render(conn, "index.html", cohorts: cohorts)
  end

  def new(conn, _params) do
    changeset = Cohorts.change_cohort(%Cohort{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"cohort" => cohort_params}) do
    case Cohorts.create_cohort(cohort_params) do
      {:ok, cohort} ->
        conn
        |> put_flash(:info, "Cohort created successfully.")
        |> redirect(to: cohort_path(conn, :show, cohort))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    cohort = Cohorts.get_cohort!(id)
    render(conn, "show.html", cohort: cohort)
  end

  def edit(conn, %{"id" => id}) do
    cohort = Cohorts.get_cohort!(id)
    changeset = Cohorts.change_cohort(cohort)
    render(conn, "edit.html", cohort: cohort, changeset: changeset)
  end

  def update(conn, %{"id" => id, "cohort" => cohort_params}) do
    cohort = Cohorts.get_cohort!(id)

    case Cohorts.update_cohort(cohort, cohort_params) do
      {:ok, cohort} ->
        conn
        |> put_flash(:info, "Cohort updated successfully.")
        |> redirect(to: cohort_path(conn, :show, cohort))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", cohort: cohort, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    cohort = Cohorts.get_cohort!(id)
    {:ok, _cohort} = Cohorts.delete_cohort(cohort)

    conn
    |> put_flash(:info, "Cohort deleted successfully.")
    |> redirect(to: cohort_path(conn, :index))
  end

  def search(conn, %{"query" => query}) do
    cohorts = Cohorts.search(query)
    render(conn, "index.html", cohorts: cohorts)
  end
end

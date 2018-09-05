defmodule LetsColearnWeb.ResourceController do
  use LetsColearnWeb, :controller

  alias LetsColearn.{Aim, Repo}
  alias LetsColearn.Aim.Resource

  def index(conn, %{"milestone_id" => id}) do
    milestone = Aim.get_milestone!(id) |> Repo.preload(:resources) |> Repo.preload(:goal)
    render(conn, "index.html", milestone: milestone)
  end

  def new(conn, %{"milestone_id" => id}) do
    milestone = Aim.get_milestone!(id) |> Repo.preload(:resources)
    changeset = Aim.change_resource(%Resource{})
    render(conn, "new.html", changeset: changeset, milestone: milestone)
  end

  def create(conn, %{"resource" => resource_params, "milestone_id" => milestone_id}) do
    milestone = Aim.get_milestone!(milestone_id) |> Repo.preload(:resources)
    user = LetsColearn.Guardian.Plug.current_resource(conn)
    case Aim.create_resource(resource_params, milestone, user) do
      {:ok, resource} ->
        conn
        |> put_flash(:info, "Resource created successfully.")
        |> redirect(to: milestone_resource_path(conn, :index, milestone_id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, milestone: milestone)
    end
  end

  def delete(conn, %{"id" => id, "milestone_id" => milestone_id}) do
    resource = Aim.get_resource!(id)
    {:ok, _resource} = Aim.delete_resource(resource)

    conn
    |> put_flash(:info, "Resource deleted successfully.")
    |> redirect(to: milestone_resource_path(conn, :index, milestone_id))
  end
end

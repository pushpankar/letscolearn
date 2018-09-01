defmodule LetsColearnWeb.MilestoneController do
  use LetsColearnWeb, :controller

  alias LetsColearn.Aim
  alias LetsColearn.Aim.Milestone

  def index(conn, _params) do
    milestones = Aim.list_milestones()
    render(conn, "index.html", milestones: milestones)
  end

  def new(conn, _params) do
    changeset = Aim.change_milestone(%Milestone{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"milestone" => milestone_params}) do
    case Aim.create_milestone(milestone_params) do
      {:ok, milestone} ->
        conn
        |> put_flash(:info, "Milestone created successfully.")
        |> redirect(to: milestone_path(conn, :show, milestone))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    milestone = Aim.get_milestone!(id)
    render(conn, "show.html", milestone: milestone)
  end

  def edit(conn, %{"id" => id}) do
    milestone = Aim.get_milestone!(id)
    changeset = Aim.change_milestone(milestone)
    render(conn, "edit.html", milestone: milestone, changeset: changeset)
  end

  def update(conn, %{"id" => id, "milestone" => milestone_params}) do
    milestone = Aim.get_milestone!(id)

    case Aim.update_milestone(milestone, milestone_params) do
      {:ok, milestone} ->
        conn
        |> put_flash(:info, "Milestone updated successfully.")
        |> redirect(to: milestone_path(conn, :show, milestone))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", milestone: milestone, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    milestone = Aim.get_milestone!(id)
    {:ok, _milestone} = Aim.delete_milestone(milestone)

    conn
    |> put_flash(:info, "Milestone deleted successfully.")
    |> redirect(to: milestone_path(conn, :index))
  end
end

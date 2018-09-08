defmodule LetsColearnWeb.MilestoneController do
  use LetsColearnWeb, :controller

  import Ecto.Query, warn: false
  alias LetsColearn.Aim
  alias LetsColearn.Aim.Milestone
  alias LetsColearn.{Repo, Guardian}

  def index(conn, %{"goal_id" => id}) do
    query = 
    goal = Aim.get_goal!(id) |> Repo.preload([milestones: from(m in Milestone, order_by: [asc: m.inserted_at])]) |> Repo.preload(:users)
    render(conn, "index.html", goal: goal)
  end

  def new(conn, %{"goal_id" => id}) do
    goal = Aim.get_goal!(id) |> Repo.preload(:milestones)
    changeset = Aim.change_milestone(%Milestone{})
    render(conn, "new.html", changeset: changeset, goal: goal)
  end

  def create(conn, %{"goal_id" => id, "milestone" => milestone_params}) do
    goal_changeset = Aim.get_goal!(id) |> Ecto.Changeset.change
    case Aim.create_milestone(milestone_params, goal_changeset) do
      {:ok, milestone} ->
        conn
        |> put_flash(:info, "Milestone created successfully.")
        |> redirect(to: goal_milestone_path(conn, :index, id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, goal: goal_changeset)
    end
  end

  def delete(conn, %{"id" => id, "goal_id" => goal_id}) do
    milestone = Aim.get_milestone!(id)
    {:ok, _milestone} = Aim.delete_milestone(milestone)

    conn
    |> put_flash(:info, "Milestone deleted successfully.")
    |> redirect(to: goal_milestone_path(conn, :index, goal_id))
  end

end

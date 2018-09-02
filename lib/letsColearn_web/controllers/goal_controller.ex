defmodule LetsColearnWeb.GoalController do
  use LetsColearnWeb, :controller

  alias LetsColearn.{Aim, Repo}
  alias LetsColearn.Aim.Goal
  alias LetsColearn.Accounts.Auth
  alias LetsColearn.Guardian

  def index(conn, _params) do
    goals = Aim.list_goals()
    render(conn, "index.html", goals: goals)
  end

  def new(conn, _params) do
    if Guardian.Plug.current_resource(conn) do
      changeset = Aim.change_goal(%Goal{})
      render(conn, "new.html", changeset: changeset)
    else
      redirect(conn, to: "/login")
    end
  end

  # Checking authentication is not required as create route is not exposed to unauthenticated user.
  def create(conn, %{"goal" => goal_params}) do
    user_changeset = Guardian.Plug.current_resource(conn) |> Ecto.Changeset.change
    case Aim.create_goal(goal_params, user_changeset) do
      {:ok, goal} ->
        conn
        |> put_flash(:info, "Goal created successfully.")
        |> redirect(to: goal_path(conn, :show, goal))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    goal = Aim.get_goal!(id) |> Repo.preload(:milestones)
    render(conn, "show.html", goal: goal)
  end

  def edit(conn, %{"id" => id}) do
    goal = Aim.get_goal!(id)
    changeset = Aim.change_goal(goal)
    render(conn, "edit.html", goal: goal, changeset: changeset)
  end

  def update(conn, %{"id" => id, "goal" => goal_params}) do
    goal = Aim.get_goal!(id)

    if Auth.creator?(conn, goal) do
      user_changeset = Guardian.Plug.current_resource(conn) |> Ecto.Changeset.change

      case Aim.update_goal(goal, goal_params, user_changeset) do
        {:ok, goal} ->
          conn
          |> put_flash(:info, "Goal updated successfully.")
          |> redirect(to: goal_path(conn, :show, goal))
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit.html", goal: goal, changeset: changeset)
      end
    else
      redirect(conn, "/")
    end
  end

  def delete(conn, %{"id" => id}) do
    goal = Aim.get_goal!(id)
    if Auth.creator?(conn, goal) do
      {:ok, _goal} = Aim.delete_goal(goal)

      conn
      |> put_flash(:info, "Goal deleted successfully.")
      |> redirect(to: goal_path(conn, :index))
    else
      redirect(conn, to: "/")
    end
  end

end

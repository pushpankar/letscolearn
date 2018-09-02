defmodule LetsColearnWeb.CommentController do
  use LetsColearnWeb, :controller

  alias LetsColearn.{Aim, Repo}
  alias LetsColearn.Aim.Comment

  def index(conn, %{"milestone_id" => id}) do
    milestone = Aim.get_milestone!(id) |> Repo.preload(:comments)
    render(conn, "index.html", milestone: milestone)
  end

  def new(conn,  %{"milestone_id" => id}) do
    milestone = Aim.get_milestone!(id) |> Repo.preload(:comments)
    changeset = Aim.change_comment(%Comment{})
    render(conn, "new.html", changeset: changeset, milestone: milestone)
  end

  def create(conn, %{"comment" => comment_params, "milestone_id" => milestone_id}) do
    milestone = Aim.get_milestone!(milestone_id) |> Repo.preload(:comments)
    user = LetsColearn.Guardian.Plug.current_resource(conn)
    case Aim.create_comment(comment_params, milestone, user) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: milestone_comment_path(conn, :index, milestone_id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, milestone: milestone)
    end
  end

  def delete(conn, %{"id" => id, "milestone_id" => milestone_id}) do
    comment = Aim.get_comment!(id)
    {:ok, _comment} = Aim.delete_comment(comment)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: milestone_comment_path(conn, :index, milestone_id))
  end
end

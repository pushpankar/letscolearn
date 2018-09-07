defmodule LetsColearn.Aim do
  @moduledoc """
  The Aim context.
  """

  import Ecto.Query, warn: false
  alias LetsColearn.Guardian
  alias LetsColearn.Repo
  require IEx

  alias LetsColearn.Aim.{Goal, GoalUser}
  alias LetsColearn.Accounts.User

  @doc """
  Returns the list of goals.

  ## Examples

      iex> list_goals()
      [%Goal{}, ...]

  """
  def list_goals do
    Goal
    |> Repo.all()
    |> Repo.preload(:creator)
  end

  @doc """
    As of now, active means, those which have not ended
  """
  def list_active_goals do
      query = from g in Goal,
                where: g.end_date > from_now(0, "day"),
                order_by: g.start_date
      Repo.all(query)
      |> Repo.preload(:creator)
  end

  def list_upcoming_goals do
      query = from g in Goal,
                where: g.start_date > from_now(0, "day"),
                order_by: g.start_date
      Repo.all(query)
      |> Repo.preload(:creator)
  end

  def user_goals(user) do
    query = from g in Goal,
                join: u in assoc(g, :users),
                where: u.id == ^user.id,
                order_by: g.start_date
    Repo.all(query)
  end

  @doc """
  Gets a single goal.

  Raises `Ecto.NoResultsError` if the Goal does not exist.

  ## Examples

      iex> get_goal!(123)
      %Goal{}

      iex> get_goal!(456)
      ** (Ecto.NoResultsError)

  """
  def get_goal!(id), do: Repo.get!(Goal, id) |> Repo.preload(:creator)

  @doc """
  Creates a goal.

  ## Examples

      iex> create_goal(%{field: value})
      {:ok, %Goal{}}

      iex> create_goal(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_goal(attrs \\ %{}, user_changeset) do
    %Goal{}
    |> Goal.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:creator, user_changeset)
    |> Repo.insert()
  end

  @doc """
  Updates a goal.

  ## Examples

      iex> update_goal(goal, %{field: new_value})
      {:ok, %Goal{}}

      iex> update_goal(goal, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_goal(%Goal{} = goal, attrs, user_changeset) do
    goal
    |> Goal.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:creator, user_changeset)
    |> Repo.update()
  end

  @doc """
  Deletes a Goal.

  ## Examples

      iex> delete_goal(goal)
      {:ok, %Goal{}}

      iex> delete_goal(goal)
      {:error, %Ecto.Changeset{}}

  """
  def delete_goal(%Goal{} = goal) do
    Repo.delete(goal)
  end

  def join_goal(%Goal{} = goal, %User{} = user) do
      GoalUser.changeset(%GoalUser{}, %{goal_id: goal.id, user_id: user.id})
      |> Repo.insert
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking goal changes.

  ## Examples

      iex> change_goal(goal)
      %Ecto.Changeset{source: %Goal{}}

  """
  def change_goal(%Goal{} = goal) do
    Goal.changeset(goal, %{})
  end

  alias LetsColearn.Aim.Milestone

  @doc """
  Returns the list of milestones.

  ## Examples

      iex> list_milestones()
      [%Milestone{}, ...]

  """
  def list_milestones do
    Repo.all(Milestone)
  end

  @doc """
  Gets a single milestone.

  Raises `Ecto.NoResultsError` if the Milestone does not exist.

  ## Examples

      iex> get_milestone!(123)
      %Milestone{}

      iex> get_milestone!(456)
      ** (Ecto.NoResultsError)

  """
  def get_milestone!(id), do: Repo.get!(Milestone, id)

  @doc """
  Creates a milestone.

  ## Examples

      iex> create_milestone(%{field: value})
      {:ok, %Milestone{}}

      iex> create_milestone(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_milestone(attrs \\ %{}, goal_changeset) do
    %Milestone{}
    |> Milestone.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:goal, goal_changeset)
    |> Repo.insert()
  end

  @doc """
  Updates a milestone.

  ## Examples

      iex> update_milestone(milestone, %{field: new_value})
      {:ok, %Milestone{}}

      iex> update_milestone(milestone, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_milestone(%Milestone{} = milestone, attrs) do
    milestone
    |> Milestone.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Milestone.

  ## Examples

      iex> delete_milestone(milestone)
      {:ok, %Milestone{}}

      iex> delete_milestone(milestone)
      {:error, %Ecto.Changeset{}}

  """
  def delete_milestone(%Milestone{} = milestone) do
    Repo.delete(milestone)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking milestone changes.

  ## Examples

      iex> change_milestone(milestone)
      %Ecto.Changeset{source: %Milestone{}}

  """
  def change_milestone(%Milestone{} = milestone) do
    Milestone.changeset(milestone, %{})
  end

  alias LetsColearn.Aim.Resource

  @doc """
  Returns the list of resources.

  ## Examples

      iex> list_resources()
      [%Resource{}, ...]

  """
  def list_resources do
    Repo.all(Resource)
  end

  @doc """
  Gets a single resource.

  Raises `Ecto.NoResultsError` if the Resource does not exist.

  ## Examples

      iex> get_resource!(123)
      %Resource{}

      iex> get_resource!(456)
      ** (Ecto.NoResultsError)

  """
  def get_resource!(id), do: Repo.get!(Resource, id)

  @doc """
  Creates a resource.

  ## Examples

      iex> create_resource(%{field: value})
      {:ok, %Resource{}}

      iex> create_resource(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_resource(attrs \\ %{}, milestone, user) do
    %Resource{}
    |> Resource.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:milestone, Ecto.Changeset.change(milestone))
    |> Ecto.Changeset.put_assoc(:user, Ecto.Changeset.change(user))
    |> Repo.insert()
  end

  @doc """
  Updates a resource.

  ## Examples

      iex> update_resource(resource, %{field: new_value})
      {:ok, %Resource{}}

      iex> update_resource(resource, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_resource(%Resource{} = resource, attrs) do
    resource
    |> Resource.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Resource.

  ## Examples

      iex> delete_resource(resource)
      {:ok, %Resource{}}

      iex> delete_resource(resource)
      {:error, %Ecto.Changeset{}}

  """
  def delete_resource(%Resource{} = resource) do
    Repo.delete(resource)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking resource changes.

  ## Examples

      iex> change_resource(resource)
      %Ecto.Changeset{source: %Resource{}}

  """
  def change_resource(%Resource{} = resource) do
    Resource.changeset(resource, %{})
  end

  def resource_count(milestone) do
    query = from r in Resource, where: r.milestone_id == ^milestone.id, select: count(r.id)
    Repo.one(query)
  end



  alias LetsColearn.Aim.Comment

  @doc """
  Returns the list of comments.

  ## Examples

      iex> list_comments()
      [%Comment{}, ...]

  """
  def list_comments do
    Repo.all(Comment)
  end

  @doc """
  Gets a single comment.

  Raises `Ecto.NoResultsError` if the Comment does not exist.

  ## Examples

      iex> get_comment!(123)
      %Comment{}

      iex> get_comment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_comment!(id), do: Repo.get!(Comment, id)

  @doc """
  Creates a comment.

  ## Examples

      iex> create_comment(%{field: value})
      {:ok, %Comment{}}

      iex> create_comment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_comment(attrs \\ %{}, milestone, user) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:milestone, Ecto.Changeset.change(milestone))
    |> Ecto.Changeset.put_assoc(:user, Ecto.Changeset.change(user))
    |> Repo.insert()
  end

  @doc """
  Updates a comment.

  ## Examples

      iex> update_comment(comment, %{field: new_value})
      {:ok, %Comment{}}

      iex> update_comment(comment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Comment.

  ## Examples

      iex> delete_comment(comment)
      {:ok, %Comment{}}

      iex> delete_comment(comment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking comment changes.

  ## Examples

      iex> change_comment(comment)
      %Ecto.Changeset{source: %Comment{}}

  """
  def change_comment(%Comment{} = comment) do
    Comment.changeset(comment, %{})
  end

  def comment_count(milestone) do
    query = from c in Comment, where: c.milestone_id == ^milestone.id, select: count(c.id)
    Repo.one(query)
  end

end

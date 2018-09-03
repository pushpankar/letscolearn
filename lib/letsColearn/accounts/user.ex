defmodule LetsColearn.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias LetsColearn.Accounts.Credential
  alias LetsColearn.Cohorts.{Cohort, Chat, Resource}
  alias LetsColearn.Aim

  schema "users" do
    field :name, :string
    field :username, :string
    has_one :credential, Credential

    has_many :comments, Aim.Comment
    has_many :resources, Aim.Resource
    many_to_many :goals, Aim.Goal, join_through: LetsColearn.Aim.GoalUser
    has_many :chats, Chat

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username])
    |> validate_required([:name, :username])
    |> unique_constraint(:username)
  end
end

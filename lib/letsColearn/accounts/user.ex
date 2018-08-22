defmodule LetsColearn.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias LetsColearn.Accounts.Credential
  alias LetsColearn.Cohorts.{Cohort, Chat}

  schema "users" do
    field :name, :string
    field :username, :string
    has_one :credential, Credential
    many_to_many :cohorts, Cohort, join_through: "users_cohorts"
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

defmodule LetsColearn.Cohorts.Cohort do
  use Ecto.Schema
  import Ecto.Changeset

  alias LetsColearn.Accounts.User

  schema "cohorts" do
    field :description, :string
    field :title, :string

    many_to_many :users, User, join_through: "users_cohorts"

    timestamps()
  end

  @doc false
  def changeset(cohort, attrs) do
    cohort
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end

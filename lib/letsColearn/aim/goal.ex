defmodule LetsColearn.Aim.Goal do
  use Ecto.Schema
  import Ecto.Changeset


  schema "goals" do
    field :start_date, :naive_datetime
    field :end_date, :naive_datetime
    field :goal, :string
    field :pre_requisites, :string
    belongs_to :creator, LetsColearn.Accounts.User, foreign_key: :user_id # creator
    has_many :milestones, LetsColearn.Aim.Milestone
    many_to_many :users, LetsColearn.Accounts.User, join_through: LetsColearn.Aim.GoalUser

    timestamps()
  end

  @doc false
  def changeset(goal, attrs) do
    goal
    |> cast(attrs, [:start_date, :end_date, :goal, :pre_requisites])
    |> validate_required([:start_date, :end_date, :goal, :pre_requisites])
  end
end

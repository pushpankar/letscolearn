defmodule LetsColearn.Aim.GoalUser do
  use Ecto.Schema

  alias LetsColearn.Accounts.User

  @primary_key false
  schema "goals_users" do
    belongs_to :user, User
    belongs_to :goal, LetsColearn.Aim.Goal
    timestamps # Added bonus, a join schema will also allow you to set timestamps
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> Ecto.Changeset.cast(params, [:goal_id, :user_id])
    |> Ecto.Changeset.validate_required([:goal_id, :user_id])
    # Maybe do some counter caching here!
  end
end
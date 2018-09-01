defmodule LetsColearn.Aim.Milestone do
  use Ecto.Schema
  import Ecto.Changeset


  schema "milestones" do
    field :milestone, :string
    field :goal_id, :id

    timestamps()
  end

  @doc false
  def changeset(milestone, attrs) do
    milestone
    |> cast(attrs, [:milestone])
    |> validate_required([:milestone])
  end
end

defmodule LetsColearn.Aim.Goal do
  use Ecto.Schema
  import Ecto.Changeset


  schema "goals" do
    field :end_date, :naive_datetime
    field :goal, :string
    field :pre_requisites, :string
    field :start_date, :naive_datetime
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(goal, attrs) do
    goal
    |> cast(attrs, [:start_date, :end_date, :goal, :pre_requisites])
    |> validate_required([:start_date, :end_date, :goal, :pre_requisites])
  end
end

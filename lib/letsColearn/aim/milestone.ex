defmodule LetsColearn.Aim.Milestone do
  use Ecto.Schema
  import Ecto.Changeset

  alias LetsColearn.Aim.{Goal, Comment, Resource}

  schema "milestones" do
    field :milestone, :string
    belongs_to :goal, Goal
    has_many :resources, Resource
    has_many :comments, Comment
    

    timestamps()
  end

  @doc false
  def changeset(milestone, attrs) do
    milestone
    |> cast(attrs, [:milestone])
    |> validate_required([:milestone])
  end
end

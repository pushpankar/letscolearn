defmodule LetsColearn.Aim.Comment do
  use Ecto.Schema
  import Ecto.Changeset


  schema "comments" do
    field :comment, :string
    belongs_to :user, LetsColearn.Accounts.User
    belongs_to :milestone, LetsColearn.Aim.Milestone

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:comment, :user_id, :milestone_id])
    |> validate_required([:comment, :user_id, :milestone_id])
  end
end

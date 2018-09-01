defmodule LetsColearn.Aim.Resource do
  use Ecto.Schema
  import Ecto.Changeset


  schema "resources" do
    field :resource, :string
    field :user_id, :id
    field :milestone_id, :id

    timestamps()
  end

  @doc false
  def changeset(resource, attrs) do
    resource
    |> cast(attrs, [:resource])
    |> validate_required([:resource])
  end
end

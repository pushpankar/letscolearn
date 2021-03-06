defmodule LetsColearn.Aim.Resource do
  use Ecto.Schema
  import Ecto.Changeset


  schema "resources" do
    field :resource, :string
    belongs_to :user, LetsColearn.Accounts.User
    belongs_to :milestone, LetsColearn.Aim.Milestone

    timestamps()
  end

  @doc false
  def changeset(resource, attrs) do
    resource
    |> cast(attrs, [:resource])
    |> validate_required([:resource])
  end
end

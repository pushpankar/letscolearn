defmodule LetsColearn.Cohorts.Chat do
  use Ecto.Schema
  import Ecto.Changeset


  schema "chats" do
    field :message, :string
    field :user_id, :id
    field :group_id, :id

    timestamps()
  end

  @doc false
  def changeset(chat, attrs) do
    chat
    |> cast(attrs, [:message])
    |> validate_required([:message])
  end
end

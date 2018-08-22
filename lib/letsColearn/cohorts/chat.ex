defmodule LetsColearn.Cohorts.Chat do
  use Ecto.Schema
  import Ecto.Changeset

  alias LetsColearn.Accounts.User
  alias LetsColearn.Cohorts.Cohort

  schema "chats" do
    field :message, :string
    belongs_to :user, User
    belongs_to :cohort, Cohort

    timestamps()
  end

  @doc false
  def changeset(chat, attrs) do
    chat
    |> cast(attrs, [:message, :user_id, :cohort_id])
    |> validate_required([:message, :user_id, :cohort_id])
  end
end

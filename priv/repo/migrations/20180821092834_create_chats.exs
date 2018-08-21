defmodule LetsColearn.Repo.Migrations.CreateChats do
  use Ecto.Migration

  def change do
    create table(:chats) do
      add :message, :text
      add :user_id, references(:users, on_delete: :nothing)
      add :group_id, references(:cohorts, on_delete: :nothing)

      timestamps()
    end

    create index(:chats, [:user_id])
    create index(:chats, [:group_id])
  end
end

defmodule LetsColearn.Repo.Migrations.CreateChats do
  use Ecto.Migration

  def change do
    create table(:chats) do
      add :message, :text, null: false
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :cohort_id, references(:cohorts, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:chats, [:user_id])
    create index(:chats, [:cohort_id])
  end
end

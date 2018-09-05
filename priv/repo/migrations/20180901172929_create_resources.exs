defmodule LetsColearn.Repo.Migrations.CreateResources do
  use Ecto.Migration

  def change do
    create table(:resources) do
      add :resource, :text, null: false
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :milestone_id, references(:milestones, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:resources, [:user_id])
    create index(:resources, [:milestone_id])
  end
end

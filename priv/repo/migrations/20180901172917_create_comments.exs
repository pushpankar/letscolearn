defmodule LetsColearn.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :comment, :text
      add :user_id, references(:users, on_delete: :nothing)
      add :milestone_id, references(:milestones, on_delete: :nothing)

      timestamps()
    end

    create index(:comments, [:user_id])
    create index(:comments, [:milestone_id])
  end
end

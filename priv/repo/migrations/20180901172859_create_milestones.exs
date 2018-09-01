defmodule LetsColearn.Repo.Migrations.CreateMilestones do
  use Ecto.Migration

  def change do
    create table(:milestones) do
      add :milestone, :string
      add :goal_id, references(:goals, on_delete: :nothing)

      timestamps()
    end

    create index(:milestones, [:goal_id])
  end
end

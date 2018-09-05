defmodule LetsColearn.Repo.Migrations.CreateGoalsUsers do
  use Ecto.Migration

  def change do
    create table(:goals_users, primary_key: false) do
      add :goal_id, references(:goals)
      add :user_id, references(:users)
      timestamps
    end

    create unique_index(:goals_users, [:goal_id, :user_id])
  end
end

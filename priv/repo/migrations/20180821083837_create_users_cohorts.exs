defmodule LetsColearn.Repo.Migrations.CreateUserCohort do
  use Ecto.Migration

  def change do
    create table(:users_cohorts) do
      add :user_id, references(:users)
      add :cohort_id, references(:cohorts)
    end

    create unique_index(:users_cohorts, [:user_id, :cohort_id])
  end
end

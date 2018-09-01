defmodule LetsColearn.Repo.Migrations.CreateGoals do
  use Ecto.Migration

  def change do
    create table(:goals) do
      add :start_date, :naive_datetime
      add :end_date, :naive_datetime
      add :goal, :string
      add :pre_requisites, :text
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:goals, [:user_id])
  end
end

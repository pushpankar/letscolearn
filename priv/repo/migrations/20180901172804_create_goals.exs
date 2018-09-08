defmodule LetsColearn.Repo.Migrations.CreateGoals do
  use Ecto.Migration

  def change do
    create table(:goals) do
      add :start_date, :date, null: false
      add :end_date, :date, null: false
      add :goal, :string, null: false
      add :pre_requisites, :text, null: false
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:goals, [:user_id])
  end
end

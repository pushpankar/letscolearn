defmodule LetsColearn.Repo.Migrations.CreateCohorts do
  use Ecto.Migration

  def change do
    create table(:cohorts) do
      add :title, :string
      add :description, :text

      timestamps()
    end

  end
end

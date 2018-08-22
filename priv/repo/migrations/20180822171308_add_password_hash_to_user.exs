defmodule LetsColearn.Repo.Migrations.AddPasswordHashToUser do
  use Ecto.Migration

  def change do
    alter table(:credentials) do
      add :password_hash, :string, null: false
    end

  end
end

defmodule Cooperactive.Repo.Migrations.CreateAccount do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :name, :string
      add :type, :string
      add :code, :string
      add :contra, :boolean, default: false, null: false
      add :description, :string

      timestamps()
    end

  end
end

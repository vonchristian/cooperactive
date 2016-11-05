defmodule Cooperactive.Repo.Migrations.CreateEntry do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :description, :string
      add :date, :date
      add :reference_number, :string

      timestamps()
    end

  end
end

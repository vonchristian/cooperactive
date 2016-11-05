defmodule Cooperactive.Repo.Migrations.CreateAmount do
  use Ecto.Migration

  def change do
    create table(:amounts) do
      add :type, :string
      add :amount, :decimal
      add :account_id, references(:accounts, on_delete: :nothing)
      add :entry_id, references(:entries, on_delete: :nothing)

      timestamps()
    end
    create index(:amounts, [:account_id])
    create index(:amounts, [:entry_id])

  end
end

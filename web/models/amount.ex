defmodule Cooperactive.Amount do
  use Cooperactive.Web, :model

  schema "amounts" do
    field :type, :string
    field :amount, :decimal
    belongs_to :account, Cooperactive.Account
    belongs_to :entry, Cooperactive.Entry

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:type, :amount, :account_id])
    |> validate_required([:type, :amount, :account_id])
  end

  def for_entry(query, entry) do
    from c in query,
    join: p in assoc(c, :entry),
    where: p.id == ^entry.id
  end
  def total_debits_for(entry) do 
  end
  def total_debits_for(entry) do 
  end
end

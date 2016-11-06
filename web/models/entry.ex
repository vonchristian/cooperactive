defmodule Cooperactive.Entry do
  use Cooperactive.Web, :model
  alias Decimal

  schema "entries" do
    field :description, :string
    field :date, Ecto.Date
    field :reference_number, :string

    has_many :amounts, Cooperactive.Amount


    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:description, :date, :reference_number])
    |> validate_required([:description, :date, :reference_number])
    |> cast_assoc(:amounts)
    # |> validate_debits_and_credits_are_equal
  end

  def validate_debits_and_credits_are_equal(changeset) do
    amounts = Ecto.Changeset.get_field(changeset, :amounts)
    amounts = Enum.group_by(amounts, fn(i) -> i.type end)

    credit_sum = Enum.reduce(amounts["credit"], fn(i, acc) -> Decimal.add(Decimal.new(i.amount), Decimal.new(acc)) end )
    debit_sum = Enum.reduce(amounts["debit"], fn(i, acc) -> Decimal.add(Decimal.new(i.amount), Decimal.new(acc)) end )

    if credit_sum == debit_sum do
      changeset
    else
      add_error(changeset, :amounts, "Credit and Debit amounts must be equal")
    end
  end
   def with_amounts(query) do
    from q in query, preload: [:amounts]
  end
end

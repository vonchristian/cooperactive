defmodule Cooperactive.Account do
  use Cooperactive.Web, :model

  schema "accounts" do
    field :name, :string
    field :type, :string
    field :code, :string
    field :contra, :boolean, default: false
    field :description, :string

    timestamps()
  end

  @credit_types ["asset"]
  @debit_types ["liability", "equity"]

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :type, :code, :contra, :description])
    |> validate_required([:name, :type, :code, :contra, :description])
  end
end

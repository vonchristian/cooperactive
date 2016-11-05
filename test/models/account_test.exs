defmodule Cooperactive.AccountTest do
  use Cooperactive.ModelCase

  alias Cooperactive.Account

  @valid_attrs %{code: "some content", contra: true, description: "some content", name: "some content", type: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Account.changeset(%Account{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Account.changeset(%Account{}, @invalid_attrs)
    refute changeset.valid?
  end
end

defmodule Cooperactive.EntryTest do
  use Cooperactive.ModelCase

  alias Cooperactive.Entry

  @valid_attrs %{date: %{day: 17, month: 4, year: 2010}, description: "some content", reference_number: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Entry.changeset(%Entry{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Entry.changeset(%Entry{}, @invalid_attrs)
    refute changeset.valid?
  end
end

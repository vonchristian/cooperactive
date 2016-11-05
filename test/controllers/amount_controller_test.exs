defmodule Cooperactive.AmountControllerTest do
  use Cooperactive.ConnCase

  alias Cooperactive.Amount
  @valid_attrs %{amount: "120.5", type: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, amount_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing amounts"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, amount_path(conn, :new)
    assert html_response(conn, 200) =~ "New amount"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, amount_path(conn, :create), amount: @valid_attrs
    assert redirected_to(conn) == amount_path(conn, :index)
    assert Repo.get_by(Amount, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, amount_path(conn, :create), amount: @invalid_attrs
    assert html_response(conn, 200) =~ "New amount"
  end

  test "shows chosen resource", %{conn: conn} do
    amount = Repo.insert! %Amount{}
    conn = get conn, amount_path(conn, :show, amount)
    assert html_response(conn, 200) =~ "Show amount"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, amount_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    amount = Repo.insert! %Amount{}
    conn = get conn, amount_path(conn, :edit, amount)
    assert html_response(conn, 200) =~ "Edit amount"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    amount = Repo.insert! %Amount{}
    conn = put conn, amount_path(conn, :update, amount), amount: @valid_attrs
    assert redirected_to(conn) == amount_path(conn, :show, amount)
    assert Repo.get_by(Amount, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    amount = Repo.insert! %Amount{}
    conn = put conn, amount_path(conn, :update, amount), amount: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit amount"
  end

  test "deletes chosen resource", %{conn: conn} do
    amount = Repo.insert! %Amount{}
    conn = delete conn, amount_path(conn, :delete, amount)
    assert redirected_to(conn) == amount_path(conn, :index)
    refute Repo.get(Amount, amount.id)
  end
end

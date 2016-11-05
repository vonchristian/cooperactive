defmodule Cooperactive.AmountController do
  use Cooperactive.Web, :controller

  alias Cooperactive.Amount

  def index(conn, _params) do
    amounts = Repo.all(Amount)
    render(conn, "index.html", amounts: amounts)
  end

  def new(conn, _params) do
    changeset = Amount.changeset(%Amount{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"amount" => amount_params}) do
    changeset = Amount.changeset(%Amount{}, amount_params)

    case Repo.insert(changeset) do
      {:ok, _amount} ->
        conn
        |> put_flash(:info, "Amount created successfully.")
        |> redirect(to: amount_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    amount = Repo.get!(Amount, id)
    render(conn, "show.html", amount: amount)
  end

  def edit(conn, %{"id" => id}) do
    amount = Repo.get!(Amount, id)
    changeset = Amount.changeset(amount)
    render(conn, "edit.html", amount: amount, changeset: changeset)
  end

  def update(conn, %{"id" => id, "amount" => amount_params}) do
    amount = Repo.get!(Amount, id)
    changeset = Amount.changeset(amount, amount_params)

    case Repo.update(changeset) do
      {:ok, amount} ->
        conn
        |> put_flash(:info, "Amount updated successfully.")
        |> redirect(to: amount_path(conn, :show, amount))
      {:error, changeset} ->
        render(conn, "edit.html", amount: amount, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    amount = Repo.get!(Amount, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(amount)

    conn
    |> put_flash(:info, "Amount deleted successfully.")
    |> redirect(to: amount_path(conn, :index))
  end
end

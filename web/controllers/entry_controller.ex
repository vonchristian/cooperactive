defmodule Cooperactive.EntryController do
  use Cooperactive.Web, :controller

  alias Cooperactive.Entry
  alias Cooperactive.Amount


  def index(conn, _params) do
    entries = Repo.all from p in Entry, preload: [:amounts]
    render(conn, "index.html", entries: entries)
  end

  def new(conn, _params) do
    changeset = Entry.changeset(%Entry{amounts: [%Amount{type: "debit"}, %Amount{type: "credit"}]})
    accounts = Repo.all(Cooperactive.Account) |> Enum.map(&{&1.name, &1.id})
    render(conn, "new.html", changeset: changeset, accounts: accounts)
  end

  def create(conn, %{"entry" => entry_params}) do
     changeset = Entry.changeset(%Entry{}, entry_params)
      accounts = Repo.all(Cooperactive.Account) |> Enum.map(&{&1.name, &1.id})
    case Repo.insert(changeset) do
      {:ok, _amount} ->
        conn
        |> put_flash(:info, "Entry created successfully.")
        |> redirect(to: entry_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, accounts: accounts)
    end
  end

  def show(conn, %{"id" => id}) do
    entry = Repo.get!(Entry, id)
    render(conn, "show.html", entry: entry)
  end

  def edit(conn, %{"id" => id}) do
    entry = Repo.get!(Entry, id) |> Repo.preload(:amounts)
    changeset = Entry.changeset(entry)
    render(conn, "edit.html", entry: entry, changeset: changeset)
  end

  def update(conn, %{"id" => id, "entry" => entry_params}) do
    entry = Repo.get!(Entry, id) |> Repo.preload(:amounts)
    changeset = Entry.changeset(entry, entry_params)

    case Repo.update(changeset) do
      {:ok, entry} ->
        conn
        |> put_flash(:info, "Entry updated successfully.")
        |> redirect(to: entry_path(conn, :show, entry))
      {:error, changeset} ->
        render(conn, "edit.html", entry: entry, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    entry = Repo.get!(Entry, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(entry)

    conn
    |> put_flash(:info, "Entry deleted successfully.")
    |> redirect(to: entry_path(conn, :index))
  end
end

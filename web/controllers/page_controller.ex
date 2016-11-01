defmodule Cooperactive.PageController do
  use Cooperactive.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

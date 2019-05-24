defmodule HelloWeb.PageController do
  use HelloWeb, :controller

  def index(conn, _params) do
    # conn
    # |> put_status(:not_found)
    # |> put_view(HelloWeb.ErrorView)
    # |> render("404.html")

    render(conn, :index)
  end
end

defmodule HelloWeb.HelloController do
  use HelloWeb, :controller

  def index(conn, _params) do
    conn
    |> put_layout(false)
    |> render("index.html")
  end

  def show(conn, %{"messenger"=> messenger}) do
    render(conn, "show.html", messenger: messenger)
  end
end

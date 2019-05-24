defmodule HelloWeb.HelloController do
  use HelloWeb, :controller

  def index(conn, _params) do
    conn
    |> put_layout(false)
    |> render("index.html")
  end

  def show(conn, %{"messenger"=> messenger}) do
    conn
    |> put_layout("admin.html")
    |> render("index.html", messenger: messenger)
  end
end

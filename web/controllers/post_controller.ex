defmodule Blurg.PostController do
  use Blurg.Web, :controller

  alias Blurg.Data

  def index(conn, _params) do
    post = Data.Post.build(conn)
    data = %{post: post}
    render(conn, "index.html", data: data)
  end

  def show(conn, _params) do
    post = Data.Post.build(conn)
    data = %{post: post}
    render(conn, "show.html", data: data)
  end

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def edit(conn, _params) do
    render(conn, "edit.html")
  end
end

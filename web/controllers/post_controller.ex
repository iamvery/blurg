defmodule Blurg.PostController do
  use Blurg.Web, :controller

  alias Blurg.{Data, Post}

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

  def delete(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    Repo.delete!(post)
    redirect(conn, to: post_path(conn, :index))
  end
end

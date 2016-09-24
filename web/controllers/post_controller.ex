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
    changeset = Post.changeset(%Post{})
    post_form = Data.PostForm.build(conn, changeset)
    data = %{post_form: post_form}
    render(conn, "new.html", data: data)
  end

  def edit(conn, %{"id" => id}) do
    data = %{
      post_link: [href: post_path(conn, :show, id)],
    }
    render(conn, "edit.html", data: data)
  end

  def create(conn, %{"post" => post_params}) do
    changeset = Post.changeset(%Post{}, post_params)
    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post created")
        |> redirect(to: post_path(conn, :index))
      {:error, changeset} ->
        post_form = Data.PostForm.build(conn, changeset)
        data = %{post_form: post_form}
        conn
        |> put_flash(:error, "Failed to create post")
        |> render("new.html", data: data)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    Repo.delete!(post)
    redirect(conn, to: post_path(conn, :index))
  end
end

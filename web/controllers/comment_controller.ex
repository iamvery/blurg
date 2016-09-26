defmodule Blurg.CommentController do
  use Blurg.Web, :controller

  alias Blurg.Comment

  def create(conn, %{"post_id" => post_id, "comment" => comment_params}) do
    changeset = Comment.changeset(%Comment{}, Map.merge(comment_params, %{"post_id" => post_id}))

    case Repo.insert(changeset) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment created")
        |> redirect(to: post_path(conn, :show, post_id))
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Comment failed")
        |> redirect(to: post_path(conn, :show, post_id))
    end
  end
end

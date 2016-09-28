defmodule Blurg.Data.PostForm do
  use Blurg.Data
  import Blurg.Router.Helpers

  def build(conn, action, changeset) when action in [:new, :create] do
    post_path(conn, :create) |> form("post", %{
      title: [name: "post[title]", value: changeset.changes[:title]],
      body: {changeset.changes[:body], name: "post[body]"},
    })
  end

  def build(%{params: %{"id" => id}} = conn, action, [post, changeset]) when action in [:edit, :update] do
    post_path(conn, :update, id) |> form("patch", %{
      title: [name: "post[title]", value: Map.get(changeset.changes, :title, post.title)],
      body: {Map.get(changeset.changes, :body, post.body), name: "post[body]"},
    })
  end
end

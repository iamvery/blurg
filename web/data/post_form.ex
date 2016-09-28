defmodule Blurg.Data.PostForm do
  use Blurg.Data
  import Blurg.Router.Helpers

  def build(conn, action, changeset) when action in [:new, :create] do
    {
      %{
        csrf: [name: "_csrf_token", value: Phoenix.Controller.get_csrf_token],
        title: [name: "post[title]", value: changeset.changes[:title]],
        body: {changeset.changes[:body], name: "post[body]"},
      },
      action: post_path(conn, :create), method: "post",
    }
  end

  def build(%{params: %{"id" => id}} = conn, action, [post, changeset]) when action in [:edit, :update] do
    {
      %{
        csrf: [name: "_csrf_token", value: Phoenix.Controller.get_csrf_token],
        method: [name: "_method", value: "patch"],
        title: [name: "post[title]", value: Map.get(changeset.changes, :title, post.title)],
        body: {Map.get(changeset.changes, :body, post.body), name: "post[body]"},
      },
      action: post_path(conn, :update, id), method: "post",
    }
  end
end

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
end

defmodule Blurg.Data.Post do
  use Blurg.Data
  import Blurg.Router.Helpers

  def build(conn, :index, _opts) do
    # TODO this doesn't seem very idiomatic
    posts = Blurg.Repo.all(Blurg.Post) |> Blurg.Repo.preload(:comments)
    Enum.map posts, fn post ->
      %{
        title: post.title,
        comment_count: post.comments |> length,
        show_link: post_path(conn, :show, post) |> a,
        edit_link: post_path(conn, :edit, post) |> a,
      }
    end
  end

  def build(%{params: %{"id" => id}} = conn, :show, _opts) do
    post = Blurg.Repo.get!(Blurg.Post, id) |> Blurg.Repo.preload(:comments)
    %{
      title: post.title,
      created_at: Timex.format!(post.inserted_at, "{relative}", :relative),
      body: Earmark.to_html(post.body) |> Phoenix.HTML.raw,
      comment: Enum.map(post.comments, &Map.merge(&1, %{
        delete_form: post_comment_path(conn, :delete, id, &1.id) |> form("delete"),
      })),
      comment_form: post_comment_path(conn, :create, post) |> form("post", %{body: [name: "comment[body]"]}),
      edit_link: a(post_path(conn, :edit, id)),
      delete_form: post_path(conn, :delete, id) |> form("delete"),
    }
  end
end

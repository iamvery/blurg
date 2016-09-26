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
        show_link: [href: post_path(conn, :show, post)],
        edit_link: [href: post_path(conn, :edit, post)],
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
        delete_form: {
          %{
            csrf: [name: "_csrf_token", value: Phoenix.Controller.get_csrf_token],
            method: [name: "_method", value: "delete"],
          },
          action: post_comment_path(conn, :delete, id, &1.id), method: "post",
        },
      })),
      comment_form: {
        %{
          csrf: [name: "_csrf_token", value: Phoenix.Controller.get_csrf_token],
          body: [name: "comment[body]"],
        },
        action: post_comment_path(conn, :create, post), method: "post",
      },
      edit_link: [href: post_path(conn, :edit, id)],
      delete_form: {
        %{
          csrf: [name: "_csrf_token", value: Phoenix.Controller.get_csrf_token],
          method: [name: "_method", value: "delete"],
        },
        [action: post_path(conn, :delete, id), method: "post"],
      },
    }
  end
end

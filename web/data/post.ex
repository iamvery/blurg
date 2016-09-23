defmodule Blurg.Data.Post do
  use Blurg.Data
  import Blurg.Router.Helpers

  def build(conn, :index, _opts) do
    Enum.map Blurg.Repo.all(Blurg.Post), fn post ->
      %{
        title: post.title,
        show_link: [href: post_path(conn, :show, post)],
        edit_link: [href: post_path(conn, :edit, post)],
      }
    end
  end

  def build(%{params: %{"id" => id}} = conn, :show, _opts) do
    post = Blurg.Repo.get!(Blurg.Post, id)
    %{
      title: post.title,
      created_at: Timex.format!(post.inserted_at, "{relative}", :relative),
      body: post.body,
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

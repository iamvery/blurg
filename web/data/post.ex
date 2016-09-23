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
end

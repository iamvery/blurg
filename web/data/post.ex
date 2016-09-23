defmodule Blurg.Data.Post do
  use Blurg.Data

  def build(_conn, :index, _opts) do
    Blurg.Repo.all(Blurg.Post)
  end
end

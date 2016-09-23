defmodule Blurg.PageController do
  use Blurg.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

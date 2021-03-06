defmodule Blurg.Router do
  use Blurg.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Ratchet.Plug.Data
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Blurg do
    pipe_through :browser # Use the default browser stack

    get "/", PostController, :index
    resources "/posts", PostController do
      resources "/comments", CommentController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", Blurg do
  #   pipe_through :api
  # end
end

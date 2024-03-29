defmodule ForumWeb.Router do
  use ForumWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ForumWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/api", ForumWeb do
    pipe_through :api
    resources "/posts", PostController, except: [:new, :edit]
    resources "/users", UserController, except: [:new, :edit]
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ForumWeb.Telemetry
    end
  end
end

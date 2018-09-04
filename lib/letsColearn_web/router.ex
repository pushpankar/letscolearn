defmodule LetsColearnWeb.Router do
  use LetsColearnWeb, :router

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

  pipeline :auth do
    plug LetsColearn.Pipeline
  end

  pipeline :ensure_authed_access do
    plug Guardian.Plug.EnsureAuthenticated, claims: %{"typ" => "access"}, handler: LetsColearn.AuthErrorHandler
  end

  scope "/", LetsColearnWeb do
    pipe_through [:browser, :auth]

    resources "/goals", GoalController, only: [:index] do
      resources "/milestones", MilestoneController, only: [:index]
    end
    resources "/milestones", MilestoneController, only: [] do
      resources "/resources", ResourceController, only: [:index]
      resources "/comments", CommentController, only: [:index]
    end

    # get "/", HomeController, :index
    resources "/users", UserController, only: [:new, :create]
    get    "/login",  SessionController, :new
    post   "/login",  SessionController, :create

    pipe_through [:ensure_authed_access]
    resources "/users", UserController, except: [:new, :create, :index, :delete]
    resources "/goals", GoalController, except: [:index, :show, :delete] do
      resources "/milestones", MilestoneController, only: [:new, :create]
    end
    post "/goals/:id/join", GoalController, :join

    resources "/milestones", MilestoneController, only: [] do
      resources "/resources", ResourceController, only: [:new, :create]
      resources "/comments", CommentController, only: [:new, :create]
    end

    delete "/logout", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", LetsColearnWeb do
  #   pipe_through :api
  # end
end

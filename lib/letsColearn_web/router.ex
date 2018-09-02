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
    plug Guardian.Plug.EnsureAuthenticated, claims: %{"typ" => "access"}
  end

  scope "/", LetsColearnWeb do
    pipe_through [:browser, :auth]

    resources "/goals", GoalController, only: [:index, :new, :show]
    resources "/milestones", MilestoneController
    resources "/resources", ResourceController
    resources "/comments", CommentController

    get "/", HomeController, :index

    resources "/cohorts", CohortController, except: [:delete]
    post "/cohorts/search", CohortController, :search

    resources "/users", UserController, only: [:new, :create]

    get    "/login",  SessionController, :new
    post   "/login",  SessionController, :create
    
    pipe_through [:ensure_authed_access]
    resources "/users", UserController, except: [:new, :create, :index, :delete]
    resources "/goals", GoalController, except: [:index, :show, :new]




    resources "/cohorts", CohortController, only: [] do
      get "/chats", ChatController, :index
    end
    post "/cohorts/join/:id", CohortController, :join

    delete "/logout", SessionController, :delete

  end

  # Other scopes may use custom stacks.
  # scope "/api", LetsColearnWeb do
  #   pipe_through :api
  # end
end

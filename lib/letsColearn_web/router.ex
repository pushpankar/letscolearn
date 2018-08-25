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
    pipe_through :browser # Use the default browser stack

    resources "/cohorts", CohortController
    post "/cohorts/search", CohortController, :search


    pipe_through [:browser, :auth]

    get "/", HomeController, :index

    resources "/users", UserController, only: [:new, :create]

    get    "/login",  SessionController, :new
    post   "/login",  SessionController, :create
    delete "/logout", SessionController, :delete
    
    pipe_through [:ensure_authed_access]
    resources "/users", UserController, except: [:new, :create]
    resources "/chats", ChatController
    post "/cohorts/join/:id", CohortController, :join

  end

  scope "/", LetsColearnWeb do

  end

  # Other scopes may use custom stacks.
  # scope "/api", LetsColearnWeb do
  #   pipe_through :api
  # end
end

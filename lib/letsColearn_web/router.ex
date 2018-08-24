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

    get "/", PageController, :index
    resources "/cohorts", CohortController
    resources "/chats", ChatController
  end

  scope "/", LetsColearnWeb do
    pipe_through [:browser, :auth]
    resources "/users", UserController, only: [:new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete],
                                              singleton: true
    
    pipe_through [:ensure_authed_access]
    resources "/users", UserController, except: [:new, :create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", LetsColearnWeb do
  #   pipe_through :api
  # end
end

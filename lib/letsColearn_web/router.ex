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

  pipeline :maybe_browser_auth do
    plug Guardian.Plug.Pipeline, module: LetsColearn.Guardian,
                                 error_handler: MyApp.AuthErrorHandler
    plug(Guardian.Plug.VerifySession)
    plug(Guardian.Plug.VerifyHeader, realm: "Bearer")
    plug(Guardian.Plug.LoadResource, allow_blank: true)
  end
  
  pipeline :ensure_authed_access do
    plug(Guardian.Plug.EnsureAuthenticated, %{"typ" => "access", handler: LetsColearn.HttpErrorHandler})
  end

  scope "/", LetsColearnWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/cohorts", CohortController
    resources "/chats", ChatController
  end

  scope "/", LetsColearnWeb do
    pipe_through [:browser, :maybe_browser_auth]
    resources "/users", UserController
    # , only: [:new, :show, :update, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", LetsColearnWeb do
  #   pipe_through :api
  # end
end

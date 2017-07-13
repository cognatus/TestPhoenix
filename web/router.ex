defmodule Test.Router do
  use Test.Web, :router

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

  pipeline :with_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug Test.CurrentUser
  end

  pipeline :login_required do
    plug Guardian.Plug.EnsureAuthenticated,
      handler: Test.GuardianErrorHandler
  end

  #no session
  scope "/", Test do
    pipe_through [ :browser, :with_session ] # Use the default browser stack

    get "/", PageController, :index

    resources "/users", UserController
    resources "/sessions", SessionController

    #session
    scope "/" do
      pipe_through :login_required

      resources "/users", UserController do
        resources "/notes", NoteController
      end

    end

  end

  # Other scopes may use custom stacks.
  # scope "/api", Test do
  #   pipe_through :api
  # end
end

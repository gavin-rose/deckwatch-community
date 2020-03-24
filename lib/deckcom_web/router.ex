defmodule DeckcomWeb.Router do
  use DeckcomWeb, :router
  require Ueberauth

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

  #Auth Routing // Auth0
  scope "/auth", DeckcomWeb do
    pipe_through :browser
    
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
  end

  scope "/", DeckcomWeb do
    pipe_through :browser

    #Home
    get "/", PageController, :index

    #Auth0 Logout Path
    get "/logout", AuthController, :logout

    #Get,Post,Update,Delete,Index for Content
    resources "/users", UserController
  end

end

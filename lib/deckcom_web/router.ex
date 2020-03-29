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

    #Admin Panel
    get "/admin", PageController, :admin
    resources "/genisets", GenisetController

    #Auth0 Logout Path
    get "/logout", AuthController, :logout

    #Content
    resources "/users", UserController
    resources "/decks", DeckController
    resources "/games", GameController
  end

end

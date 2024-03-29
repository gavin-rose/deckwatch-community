defmodule DeckcomWeb.AuthController do
    use DeckcomWeb, :controller
    alias DeckcomWeb.Router.Helpers
    alias Deckcom.Users
  
    plug Ueberauth
  
    alias Ueberauth.Strategy.Helpers
  
    def logout(conn, _params) do
      conn
      #|> put_flash(:info, "You have been logged out!")
      |> configure_session(drop: true)
      |> redirect(external: "https://debugr.auth0.com/v2/logout?returnTo=https%3A%2F%2Fblooming-retreat-92794.herokuapp.com%2F&client_id=z0lsC3TDK6yW8GRxWzeqiafH69Ly0XoC")
    end
  
    def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
      conn
      #|> put_flash(:error, "Failed to authenticate.")
      |> redirect(to: "/")
    end
  
    def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
      case UserFromAuth.find_or_create(auth) do
        {:ok, user} ->
          if Users.get_user_by_email(email: user.email) === nil do
            case user.email do
              "gtfrexo@gmail.com" ->
                isAdmin = true
              "gavin.rose@debugr.net" ->
                  isAdmin = true
              _ ->
                isAdmin = false
            end
            userx = Users.create_user(%{name_full: user.name, email: user.email, isAdmin: isAdmin})
            IO.puts inspect userx
          end
          link = "/"
          conn
          #|> put_flash(:info, "Successfully authenticated as " <> user.email <> ".")
          |> put_session(:current_user, user)
          |> redirect(to: link)
          
        {:error, reason} ->
          conn
          #|> put_flash(:error, reason)
          |> redirect(to: "/")
      end
    end
  end
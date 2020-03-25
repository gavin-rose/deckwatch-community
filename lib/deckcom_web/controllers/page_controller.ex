defmodule DeckcomWeb.PageController do
  use DeckcomWeb, :controller

  plug :secure
  defp secure(conn, _params) do
    user = get_session(conn, :current_user)
    case user do
    #can people get in without logging in? ask team
     nil ->
         conn 
         #|> assign(:current_user, nil) #
         |> redirect(to: "/auth/auth0") |> halt
     _ ->
       conn
       |> assign(:current_user, user)
    end
  end

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def admin(conn, _params) do
    render(conn, "admin.html")
  end
end

defmodule DeckcomWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "main:lobby", DeckcomWeb.MainChannel

  ## Connect and authentify connection via current_user
  #################################################
  ## *Insert Auth0 Logic Once Implemented Fully* ##
  #################################################
  def connect(_params, socket) do
    {:ok, socket}
  end

  ## Socket is nil (anon), once Auth0 logic implemented, broadcast user changes across
  ## the site here. This will be where room joining logic eventually goes!
  def id(_socket), do: nil
end

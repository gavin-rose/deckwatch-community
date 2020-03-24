defmodule DeckcomWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "main:lobby", DeckcomWeb.MainChannel

  ## Connect and authentify connection via current_user
  #################################################
  ## *Insert Auth0 Logic Once Implemented Fully* ##
  #################################################
  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  # Count connections throughout the channels
  def count do
    acc = fn {channel, _}, map -> Map.update(map, channel, 1, &(&1 + 1)) end
    countTotals = :ets.foldl(acc, %{}, Deckcom.PubSub.Local0)
    IO.puts inspect countTotals
  end

  ## Socket is nil (anon), once Auth0 logic implemented, broadcast user changes across
  ## the site here. This will be where room joining logic eventually goes!
  def id(_socket), do: nil
end

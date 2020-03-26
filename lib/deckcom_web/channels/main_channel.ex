defmodule DeckcomWeb.MainChannel do
  use DeckcomWeb, :channel

  def handle_info(:after_join, socket) do
    Deckcom.Message.get_messages()
    |> Enum.each(fn msg -> push(socket, "shout", %{
        name: msg.name,
        message: msg.message,
      }) end)
    {:noreply, socket}
  end

  def join("main:lobby", payload, socket) do
    if authorized?(payload) do
      send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (main:lobby).
  def handle_in("shout", payload, socket) do
    IO.puts inspect payload
    #FIX DB MERGE FIRST
    #IO.puts inspect elem(Deckcom.Cards.get_cards(name: elem(Map.fetch(payload, "cont_card"), 1)), 0).
    Deckcom.Message.changeset(%Deckcom.Message{}, payload) |> Deckcom.Repo.insert 
    sendWpayload = Map.put(payload, "cont_card", "https://i.picsum.photos/id/0/5616/3744.jpg")
    IO.puts inspect sendWpayload
    broadcast socket, "shout", sendWpayload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end

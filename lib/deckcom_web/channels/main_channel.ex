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
    ca = elem(Map.fetch(payload, "cont_card"), 1)
    IO.puts inspect "CARD #{ca}"
    if ca != nil do 
      card = Deckcom.Cards.get_cards(name: ca)
    else
      card = nil
    end
    if card != nil do
      #IO.puts inspect "CARD #{card}"
      for car <- card do
        #IO.puts inspect "CARD #{car}"
        payload = Map.put(payload, "cont_card", car.image_uris)
        Deckcom.Message.changeset(%Deckcom.Message{}, payload) |> Deckcom.Repo.insert 
        broadcast socket, "shout", payload
        {:noreply, socket}
      end
    else
      Deckcom.Message.changeset(%Deckcom.Message{}, payload) |> Deckcom.Repo.insert 
      broadcast socket, "shout", payload
      {:noreply, socket}
    end
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end

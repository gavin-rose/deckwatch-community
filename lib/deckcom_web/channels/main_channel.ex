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
    IO.puts inspect "Search for: #{ca}"
    case ca do
      nil ->
        {:ok, IO.puts inspect "Search was nil"}
      _ ->
        case card = Deckcom.Cards.get_cards(name: ca) do
          nil ->
            Deckcom.Message.changeset(%Deckcom.Message{}, payload) |> Deckcom.Repo.insert 
            broadcast socket, "shout", payload
            {:ok, IO.puts inspect "Card was nil"}
          [_] ->
            for c <- card do
              payload = Map.put(payload, "cont_card", c.image_uris)
              Deckcom.Message.changeset(%Deckcom.Message{}, payload) |> Deckcom.Repo.insert 
              broadcast socket, "shout", payload
              {:ok, IO.puts inspect "Found in search"}
            end
          _ ->
            Deckcom.Message.changeset(%Deckcom.Message{}, payload) |> Deckcom.Repo.insert 
            broadcast socket, "shout", payload
            {:ok, IO.puts inspect "Returned without a match"}
        end
        IO.puts inspect card
    end
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end

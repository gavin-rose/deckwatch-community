defmodule DeckcomWeb.DeckController do
  use DeckcomWeb, :controller

  alias Deckcom.Decks
  alias Deckcom.Decks.Deck

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
    decks = Decks.list_decks()
    render(conn, "index.html", decks: decks)
  end

  def new(conn, _params) do
    changeset = Decks.change_deck(%Deck{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"deck" => deck_params}) do
    case Decks.create_deck(deck_params) do
      {:ok, deck} ->
        cards = String.split(elem(Map.fetch(deck_params, "in_play_text"), 1), "\n", parts: :infinity)
        cardsList = []
        for card <- cards do
          dets = String.split(card, " ", parts: 2)
          name = Enum.at(dets, 1)
          IO.puts name
          IO.puts inspect cid = Enum.at(Deckcom.Cards.get_cards(name: name), 0)
          IO.puts inspect elem(Map.fetch(cid, :id), 1)
          quantity = String.replace(Enum.at(dets, 0), "x", "") |> String.to_integer
          IO.puts inspect "QUANTITY: #{quantity}"
          if cid != nil do
            if deck.play === nil do
              Decks.update_deck(deck, %{play: [elem(Map.fetch(cid, :id), 1)]})
            else
              Decks.update_deck(deck, %{play: deck.play ++ [elem(Map.fetch(cid, :id), 1)]})
            end
          end
        end
        conn
        |> put_flash(:info, "Deck created successfully.")
        |> redirect(to: Routes.deck_path(conn, :show, deck))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    deck = Decks.get_deck!(id)
    render(conn, "show.html", deck: deck)
  end

  def edit(conn, %{"id" => id}) do
    deck = Decks.get_deck!(id)
    changeset = Decks.change_deck(deck)
    render(conn, "edit.html", deck: deck, changeset: changeset)
  end

  def update(conn, %{"id" => id, "deck" => deck_params}) do
    deck = Decks.get_deck!(id)

    case Decks.update_deck(deck, deck_params) do
      {:ok, deck} ->
        conn
        |> put_flash(:info, "Deck updated successfully.")
        |> redirect(to: Routes.deck_path(conn, :show, deck))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", deck: deck, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    deck = Decks.get_deck!(id)
    {:ok, _deck} = Decks.delete_deck(deck)

    conn
    |> put_flash(:info, "Deck deleted successfully.")
    |> redirect(to: Routes.deck_path(conn, :index))
  end
end

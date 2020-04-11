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
    user = get_session(conn, :current_user)
    uid = Deckcom.Users.get_user_by_email(email: user.email).id
    case Decks.create_deck(Map.put(deck_params, "owner", uid)) do
      {:ok, deck} ->
        String.split(elem(Map.fetch(deck_params, "in_play_text"), 1), "\r", parts: :infinity) |> run_play(0, deck.id)
        conn
        |> put_flash(:info, "Deck created successfully.")
        |> redirect(to: Routes.deck_path(conn, :index))

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

  def run_play(list, number, did) do
    deck = Decks.get_deck!(did)
    card = Enum.at(list, number)
    if card != nil do 
      dets = String.split(card, " ", parts: 2)
      name = Enum.at(dets, 1)
      cid = Enum.at(Deckcom.Cards.get_cards(name: name), 0)
      quantity = String.replace(String.replace(Enum.at(dets, 0), "\n", ""), "x", "") |> String.to_integer
      IO.puts inspect "QUANTITY: #{quantity}"
      if cid != nil do
        lis = deck.play
        if lis === nil do
          lis = []
        end
        Decks.update_deck(deck, %{play: lis ++ [elem(Map.fetch(cid, :id), 1)]})
      else
        {:ok}
      end
      run_play(list, number + 1, did)
    end
  end
end

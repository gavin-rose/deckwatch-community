defmodule Deckcom.DecksTest do
  use Deckcom.DataCase

  alias Deckcom.Decks

  describe "decks" do
    alias Deckcom.Decks.Deck

    @valid_attrs %{colors: [], mainboard: [], maybeboard: [], owner: 42, play: [], sideboard: [], type: "some type"}
    @update_attrs %{colors: [], mainboard: [], maybeboard: [], owner: 43, play: [], sideboard: [], type: "some updated type"}
    @invalid_attrs %{colors: nil, mainboard: nil, maybeboard: nil, owner: nil, play: nil, sideboard: nil, type: nil}

    def deck_fixture(attrs \\ %{}) do
      {:ok, deck} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Decks.create_deck()

      deck
    end

    test "list_decks/0 returns all decks" do
      deck = deck_fixture()
      assert Decks.list_decks() == [deck]
    end

    test "get_deck!/1 returns the deck with given id" do
      deck = deck_fixture()
      assert Decks.get_deck!(deck.id) == deck
    end

    test "create_deck/1 with valid data creates a deck" do
      assert {:ok, %Deck{} = deck} = Decks.create_deck(@valid_attrs)
      assert deck.colors == []
      assert deck.mainboard == []
      assert deck.maybeboard == []
      assert deck.owner == 42
      assert deck.play == []
      assert deck.sideboard == []
      assert deck.type == "some type"
    end

    test "create_deck/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Decks.create_deck(@invalid_attrs)
    end

    test "update_deck/2 with valid data updates the deck" do
      deck = deck_fixture()
      assert {:ok, %Deck{} = deck} = Decks.update_deck(deck, @update_attrs)
      assert deck.colors == []
      assert deck.mainboard == []
      assert deck.maybeboard == []
      assert deck.owner == 43
      assert deck.play == []
      assert deck.sideboard == []
      assert deck.type == "some updated type"
    end

    test "update_deck/2 with invalid data returns error changeset" do
      deck = deck_fixture()
      assert {:error, %Ecto.Changeset{}} = Decks.update_deck(deck, @invalid_attrs)
      assert deck == Decks.get_deck!(deck.id)
    end

    test "delete_deck/1 deletes the deck" do
      deck = deck_fixture()
      assert {:ok, %Deck{}} = Decks.delete_deck(deck)
      assert_raise Ecto.NoResultsError, fn -> Decks.get_deck!(deck.id) end
    end

    test "change_deck/1 returns a deck changeset" do
      deck = deck_fixture()
      assert %Ecto.Changeset{} = Decks.change_deck(deck)
    end
  end
end

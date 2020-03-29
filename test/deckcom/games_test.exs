defmodule Deckcom.GamesTest do
  use Deckcom.DataCase

  alias Deckcom.Games

  describe "games" do
    alias Deckcom.Games.Game

    @valid_attrs %{allowed_players: 42, attached_chat: 42, b_pool: [], c_pool: [], commander_damage: [], creator: 42, decks: [], g_pool: [], has_ended: "some has_ended", infect: [], is_full: true, life: [], name: "some name", players: [], price_limit: 42, r_pool: [], stack: [], u_pool: [], w_pool: [], was_draw: true, winner: 42}
    @update_attrs %{allowed_players: 43, attached_chat: 43, b_pool: [], c_pool: [], commander_damage: [], creator: 43, decks: [], g_pool: [], has_ended: "some updated has_ended", infect: [], is_full: false, life: [], name: "some updated name", players: [], price_limit: 43, r_pool: [], stack: [], u_pool: [], w_pool: [], was_draw: false, winner: 43}
    @invalid_attrs %{allowed_players: nil, attached_chat: nil, b_pool: nil, c_pool: nil, commander_damage: nil, creator: nil, decks: nil, g_pool: nil, has_ended: nil, infect: nil, is_full: nil, life: nil, name: nil, players: nil, price_limit: nil, r_pool: nil, stack: nil, u_pool: nil, w_pool: nil, was_draw: nil, winner: nil}

    def game_fixture(attrs \\ %{}) do
      {:ok, game} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Games.create_game()

      game
    end

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Games.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Games.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      assert {:ok, %Game{} = game} = Games.create_game(@valid_attrs)
      assert game.allowed_players == 42
      assert game.attached_chat == 42
      assert game.b_pool == []
      assert game.c_pool == []
      assert game.commander_damage == []
      assert game.creator == 42
      assert game.decks == []
      assert game.g_pool == []
      assert game.has_ended == "some has_ended"
      assert game.infect == []
      assert game.is_full == true
      assert game.life == []
      assert game.name == "some name"
      assert game.players == []
      assert game.price_limit == 42
      assert game.r_pool == []
      assert game.stack == []
      assert game.u_pool == []
      assert game.w_pool == []
      assert game.was_draw == true
      assert game.winner == 42
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      assert {:ok, %Game{} = game} = Games.update_game(game, @update_attrs)
      assert game.allowed_players == 43
      assert game.attached_chat == 43
      assert game.b_pool == []
      assert game.c_pool == []
      assert game.commander_damage == []
      assert game.creator == 43
      assert game.decks == []
      assert game.g_pool == []
      assert game.has_ended == "some updated has_ended"
      assert game.infect == []
      assert game.is_full == false
      assert game.life == []
      assert game.name == "some updated name"
      assert game.players == []
      assert game.price_limit == 43
      assert game.r_pool == []
      assert game.stack == []
      assert game.u_pool == []
      assert game.w_pool == []
      assert game.was_draw == false
      assert game.winner == 43
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_game(game, @invalid_attrs)
      assert game == Games.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Games.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Games.change_game(game)
    end
  end
end

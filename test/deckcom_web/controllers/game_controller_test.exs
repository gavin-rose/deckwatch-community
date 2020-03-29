defmodule DeckcomWeb.GameControllerTest do
  use DeckcomWeb.ConnCase

  alias Deckcom.Games

  @create_attrs %{allowed_players: 42, attached_chat: 42, b_pool: [], c_pool: [], commander_damage: [], creator: 42, decks: [], g_pool: [], has_ended: "some has_ended", infect: [], is_full: true, life: [], name: "some name", players: [], price_limit: 42, r_pool: [], stack: [], u_pool: [], w_pool: [], was_draw: true, winner: 42}
  @update_attrs %{allowed_players: 43, attached_chat: 43, b_pool: [], c_pool: [], commander_damage: [], creator: 43, decks: [], g_pool: [], has_ended: "some updated has_ended", infect: [], is_full: false, life: [], name: "some updated name", players: [], price_limit: 43, r_pool: [], stack: [], u_pool: [], w_pool: [], was_draw: false, winner: 43}
  @invalid_attrs %{allowed_players: nil, attached_chat: nil, b_pool: nil, c_pool: nil, commander_damage: nil, creator: nil, decks: nil, g_pool: nil, has_ended: nil, infect: nil, is_full: nil, life: nil, name: nil, players: nil, price_limit: nil, r_pool: nil, stack: nil, u_pool: nil, w_pool: nil, was_draw: nil, winner: nil}

  def fixture(:game) do
    {:ok, game} = Games.create_game(@create_attrs)
    game
  end

  describe "index" do
    test "lists all games", %{conn: conn} do
      conn = get(conn, Routes.game_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Games"
    end
  end

  describe "new game" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.game_path(conn, :new))
      assert html_response(conn, 200) =~ "New Game"
    end
  end

  describe "create game" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.game_path(conn, :create), game: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.game_path(conn, :show, id)

      conn = get(conn, Routes.game_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Game"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.game_path(conn, :create), game: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Game"
    end
  end

  describe "edit game" do
    setup [:create_game]

    test "renders form for editing chosen game", %{conn: conn, game: game} do
      conn = get(conn, Routes.game_path(conn, :edit, game))
      assert html_response(conn, 200) =~ "Edit Game"
    end
  end

  describe "update game" do
    setup [:create_game]

    test "redirects when data is valid", %{conn: conn, game: game} do
      conn = put(conn, Routes.game_path(conn, :update, game), game: @update_attrs)
      assert redirected_to(conn) == Routes.game_path(conn, :show, game)

      conn = get(conn, Routes.game_path(conn, :show, game))
      assert html_response(conn, 200) =~ "some updated has_ended"
    end

    test "renders errors when data is invalid", %{conn: conn, game: game} do
      conn = put(conn, Routes.game_path(conn, :update, game), game: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Game"
    end
  end

  describe "delete game" do
    setup [:create_game]

    test "deletes chosen game", %{conn: conn, game: game} do
      conn = delete(conn, Routes.game_path(conn, :delete, game))
      assert redirected_to(conn) == Routes.game_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.game_path(conn, :show, game))
      end
    end
  end

  defp create_game(_) do
    game = fixture(:game)
    {:ok, game: game}
  end
end

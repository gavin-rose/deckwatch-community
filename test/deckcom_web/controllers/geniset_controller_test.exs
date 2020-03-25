defmodule DeckcomWeb.GenisetControllerTest do
  use DeckcomWeb.ConnCase

  alias Deckcom.Genisets

  @create_attrs %{geniset_method: "some geniset_method", ran_by: 42, repeating: true, repeating_schedule: "some repeating_schedule"}
  @update_attrs %{geniset_method: "some updated geniset_method", ran_by: 43, repeating: false, repeating_schedule: "some updated repeating_schedule"}
  @invalid_attrs %{geniset_method: nil, ran_by: nil, repeating: nil, repeating_schedule: nil}

  def fixture(:geniset) do
    {:ok, geniset} = Genisets.create_geniset(@create_attrs)
    geniset
  end

  describe "index" do
    test "lists all genisets", %{conn: conn} do
      conn = get(conn, Routes.geniset_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Genisets"
    end
  end

  describe "new geniset" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.geniset_path(conn, :new))
      assert html_response(conn, 200) =~ "New Geniset"
    end
  end

  describe "create geniset" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.geniset_path(conn, :create), geniset: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.geniset_path(conn, :show, id)

      conn = get(conn, Routes.geniset_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Geniset"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.geniset_path(conn, :create), geniset: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Geniset"
    end
  end

  describe "edit geniset" do
    setup [:create_geniset]

    test "renders form for editing chosen geniset", %{conn: conn, geniset: geniset} do
      conn = get(conn, Routes.geniset_path(conn, :edit, geniset))
      assert html_response(conn, 200) =~ "Edit Geniset"
    end
  end

  describe "update geniset" do
    setup [:create_geniset]

    test "redirects when data is valid", %{conn: conn, geniset: geniset} do
      conn = put(conn, Routes.geniset_path(conn, :update, geniset), geniset: @update_attrs)
      assert redirected_to(conn) == Routes.geniset_path(conn, :show, geniset)

      conn = get(conn, Routes.geniset_path(conn, :show, geniset))
      assert html_response(conn, 200) =~ "some updated geniset_method"
    end

    test "renders errors when data is invalid", %{conn: conn, geniset: geniset} do
      conn = put(conn, Routes.geniset_path(conn, :update, geniset), geniset: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Geniset"
    end
  end

  describe "delete geniset" do
    setup [:create_geniset]

    test "deletes chosen geniset", %{conn: conn, geniset: geniset} do
      conn = delete(conn, Routes.geniset_path(conn, :delete, geniset))
      assert redirected_to(conn) == Routes.geniset_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.geniset_path(conn, :show, geniset))
      end
    end
  end

  defp create_geniset(_) do
    geniset = fixture(:geniset)
    {:ok, geniset: geniset}
  end
end

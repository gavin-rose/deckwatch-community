defmodule Deckcom.RelatedTest do
  use Deckcom.DataCase

  alias Deckcom.Related

  describe "related" do
    alias Deckcom.Related.Mtg

    @valid_attrs %{component: "some component", name: "some name", object: "some object", scryfall_id: "some scryfall_id", type_line: "some type_line", uri: "some uri"}
    @update_attrs %{component: "some updated component", name: "some updated name", object: "some updated object", scryfall_id: "some updated scryfall_id", type_line: "some updated type_line", uri: "some updated uri"}
    @invalid_attrs %{component: nil, name: nil, object: nil, scryfall_id: nil, type_line: nil, uri: nil}

    def mtg_fixture(attrs \\ %{}) do
      {:ok, mtg} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Related.create_mtg()

      mtg
    end

    test "list_related/0 returns all related" do
      mtg = mtg_fixture()
      assert Related.list_related() == [mtg]
    end

    test "get_mtg!/1 returns the mtg with given id" do
      mtg = mtg_fixture()
      assert Related.get_mtg!(mtg.id) == mtg
    end

    test "create_mtg/1 with valid data creates a mtg" do
      assert {:ok, %Mtg{} = mtg} = Related.create_mtg(@valid_attrs)
      assert mtg.component == "some component"
      assert mtg.name == "some name"
      assert mtg.object == "some object"
      assert mtg.scryfall_id == "some scryfall_id"
      assert mtg.type_line == "some type_line"
      assert mtg.uri == "some uri"
    end

    test "create_mtg/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Related.create_mtg(@invalid_attrs)
    end

    test "update_mtg/2 with valid data updates the mtg" do
      mtg = mtg_fixture()
      assert {:ok, %Mtg{} = mtg} = Related.update_mtg(mtg, @update_attrs)
      assert mtg.component == "some updated component"
      assert mtg.name == "some updated name"
      assert mtg.object == "some updated object"
      assert mtg.scryfall_id == "some updated scryfall_id"
      assert mtg.type_line == "some updated type_line"
      assert mtg.uri == "some updated uri"
    end

    test "update_mtg/2 with invalid data returns error changeset" do
      mtg = mtg_fixture()
      assert {:error, %Ecto.Changeset{}} = Related.update_mtg(mtg, @invalid_attrs)
      assert mtg == Related.get_mtg!(mtg.id)
    end

    test "delete_mtg/1 deletes the mtg" do
      mtg = mtg_fixture()
      assert {:ok, %Mtg{}} = Related.delete_mtg(mtg)
      assert_raise Ecto.NoResultsError, fn -> Related.get_mtg!(mtg.id) end
    end

    test "change_mtg/1 returns a mtg changeset" do
      mtg = mtg_fixture()
      assert %Ecto.Changeset{} = Related.change_mtg(mtg)
    end
  end
end

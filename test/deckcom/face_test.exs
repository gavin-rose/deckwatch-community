defmodule Deckcom.FaceTest do
  use Deckcom.DataCase

  alias Deckcom.Face

  describe "faces" do
    alias Deckcom.Face.Mtg

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def mtg_fixture(attrs \\ %{}) do
      {:ok, mtg} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Face.create_mtg()

      mtg
    end

    test "list_faces/0 returns all faces" do
      mtg = mtg_fixture()
      assert Face.list_faces() == [mtg]
    end

    test "get_mtg!/1 returns the mtg with given id" do
      mtg = mtg_fixture()
      assert Face.get_mtg!(mtg.id) == mtg
    end

    test "create_mtg/1 with valid data creates a mtg" do
      assert {:ok, %Mtg{} = mtg} = Face.create_mtg(@valid_attrs)
    end

    test "create_mtg/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Face.create_mtg(@invalid_attrs)
    end

    test "update_mtg/2 with valid data updates the mtg" do
      mtg = mtg_fixture()
      assert {:ok, %Mtg{} = mtg} = Face.update_mtg(mtg, @update_attrs)
    end

    test "update_mtg/2 with invalid data returns error changeset" do
      mtg = mtg_fixture()
      assert {:error, %Ecto.Changeset{}} = Face.update_mtg(mtg, @invalid_attrs)
      assert mtg == Face.get_mtg!(mtg.id)
    end

    test "delete_mtg/1 deletes the mtg" do
      mtg = mtg_fixture()
      assert {:ok, %Mtg{}} = Face.delete_mtg(mtg)
      assert_raise Ecto.NoResultsError, fn -> Face.get_mtg!(mtg.id) end
    end

    test "change_mtg/1 returns a mtg changeset" do
      mtg = mtg_fixture()
      assert %Ecto.Changeset{} = Face.change_mtg(mtg)
    end
  end
end

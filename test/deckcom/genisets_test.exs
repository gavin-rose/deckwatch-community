defmodule Deckcom.GenisetsTest do
  use Deckcom.DataCase

  alias Deckcom.Genisets

  describe "genisets" do
    alias Deckcom.Genisets.Geniset

    @valid_attrs %{geniset_method: "some geniset_method", ran_by: 42, repeating: true, repeating_schedule: "some repeating_schedule"}
    @update_attrs %{geniset_method: "some updated geniset_method", ran_by: 43, repeating: false, repeating_schedule: "some updated repeating_schedule"}
    @invalid_attrs %{geniset_method: nil, ran_by: nil, repeating: nil, repeating_schedule: nil}

    def geniset_fixture(attrs \\ %{}) do
      {:ok, geniset} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Genisets.create_geniset()

      geniset
    end

    test "list_genisets/0 returns all genisets" do
      geniset = geniset_fixture()
      assert Genisets.list_genisets() == [geniset]
    end

    test "get_geniset!/1 returns the geniset with given id" do
      geniset = geniset_fixture()
      assert Genisets.get_geniset!(geniset.id) == geniset
    end

    test "create_geniset/1 with valid data creates a geniset" do
      assert {:ok, %Geniset{} = geniset} = Genisets.create_geniset(@valid_attrs)
      assert geniset.geniset_method == "some geniset_method"
      assert geniset.ran_by == 42
      assert geniset.repeating == true
      assert geniset.repeating_schedule == "some repeating_schedule"
    end

    test "create_geniset/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Genisets.create_geniset(@invalid_attrs)
    end

    test "update_geniset/2 with valid data updates the geniset" do
      geniset = geniset_fixture()
      assert {:ok, %Geniset{} = geniset} = Genisets.update_geniset(geniset, @update_attrs)
      assert geniset.geniset_method == "some updated geniset_method"
      assert geniset.ran_by == 43
      assert geniset.repeating == false
      assert geniset.repeating_schedule == "some updated repeating_schedule"
    end

    test "update_geniset/2 with invalid data returns error changeset" do
      geniset = geniset_fixture()
      assert {:error, %Ecto.Changeset{}} = Genisets.update_geniset(geniset, @invalid_attrs)
      assert geniset == Genisets.get_geniset!(geniset.id)
    end

    test "delete_geniset/1 deletes the geniset" do
      geniset = geniset_fixture()
      assert {:ok, %Geniset{}} = Genisets.delete_geniset(geniset)
      assert_raise Ecto.NoResultsError, fn -> Genisets.get_geniset!(geniset.id) end
    end

    test "change_geniset/1 returns a geniset changeset" do
      geniset = geniset_fixture()
      assert %Ecto.Changeset{} = Genisets.change_geniset(geniset)
    end
  end
end

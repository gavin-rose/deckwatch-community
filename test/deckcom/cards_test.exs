defmodule Deckcom.CardsTest do
  use Deckcom.DataCase

  alias Deckcom.Cards

  describe "cards" do
    alias Deckcom.Cards.Mtg

    @valid_attrs %{set_type: "some set_type", power: "some power", set_uri: "some set_uri", released_at: ~D[2010-04-17], scryfall2_uri: "some scryfall2_uri", foil: true, prints_search_uri: "some prints_search_uri", tcgplayer_id: 42, watermark: "some watermark", source: "some source", digital: true, scryfall_set_uri: "some scryfall_set_uri", artist: "some artist", printed_text: "some printed_text", story_spotlight: true, textless: true, printed_name: "some printed_name", arena_id: 42, full_art: true, source_uri: "some source_uri", promo: true, rarity: "some rarity", variation_of: "some variation_of", card_back_id: "some card_back_id", illustration_id: "some illustration_id", oversized: true, object: "some object", scryfall_id: "some scryfall_id", layout: "some layout", highres_image: true, oracle_text: "some oracle_text", flavor_text: "some flavor_text", set_search_uri: "some set_search_uri", previewed_at: ~D[2010-04-17], edhrec_rank: 42, mgto_id: 42, set_name: "some set_name", border_color: "some border_color", type_line: "some type_line", reserved: true, rulings_uri: "some rulings_uri", frame: "some frame", booster: true, reprint: true, life_modifier: "some life_modifier", scryfall_uri: "some scryfall_uri", nonfoil: true, loyalty: "some loyalty", mgto_foil_id: 42, language_code: "some language_code", ...}
    @update_attrs %{set_type: "some updated set_type", power: "some updated power", set_uri: "some updated set_uri", released_at: ~D[2011-05-18], scryfall2_uri: "some updated scryfall2_uri", foil: false, prints_search_uri: "some updated prints_search_uri", tcgplayer_id: 43, watermark: "some updated watermark", source: "some updated source", digital: false, scryfall_set_uri: "some updated scryfall_set_uri", artist: "some updated artist", printed_text: "some updated printed_text", story_spotlight: false, textless: false, printed_name: "some updated printed_name", arena_id: 43, full_art: false, source_uri: "some updated source_uri", promo: false, rarity: "some updated rarity", variation_of: "some updated variation_of", card_back_id: "some updated card_back_id", illustration_id: "some updated illustration_id", oversized: false, object: "some updated object", scryfall_id: "some updated scryfall_id", layout: "some updated layout", highres_image: false, oracle_text: "some updated oracle_text", flavor_text: "some updated flavor_text", set_search_uri: "some updated set_search_uri", previewed_at: ~D[2011-05-18], edhrec_rank: 43, mgto_id: 43, set_name: "some updated set_name", border_color: "some updated border_color", type_line: "some updated type_line", reserved: false, rulings_uri: "some updated rulings_uri", frame: "some updated frame", booster: false, reprint: false, life_modifier: "some updated life_modifier", scryfall_uri: "some updated scryfall_uri", nonfoil: false, loyalty: "some updated loyalty", mgto_foil_id: 43, language_code: "some updated language_code", ...}
    @invalid_attrs %{set_type: nil, power: nil, set_uri: nil, released_at: nil, scryfall2_uri: nil, foil: nil, prints_search_uri: nil, tcgplayer_id: nil, watermark: nil, source: nil, digital: nil, scryfall_set_uri: nil, artist: nil, printed_text: nil, story_spotlight: nil, textless: nil, printed_name: nil, arena_id: nil, full_art: nil, source_uri: nil, promo: nil, rarity: nil, variation_of: nil, card_back_id: nil, illustration_id: nil, oversized: nil, object: nil, scryfall_id: nil, layout: nil, highres_image: nil, oracle_text: nil, flavor_text: nil, set_search_uri: nil, previewed_at: nil, edhrec_rank: nil, mgto_id: nil, set_name: nil, border_color: nil, type_line: nil, reserved: nil, rulings_uri: nil, frame: nil, booster: nil, reprint: nil, life_modifier: nil, scryfall_uri: nil, nonfoil: nil, loyalty: nil, mgto_foil_id: nil, language_code: nil, ...}

    def mtg_fixture(attrs \\ %{}) do
      {:ok, mtg} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cards.create_mtg()

      mtg
    end

    test "list_cards/0 returns all cards" do
      mtg = mtg_fixture()
      assert Cards.list_cards() == [mtg]
    end

    test "get_mtg!/1 returns the mtg with given id" do
      mtg = mtg_fixture()
      assert Cards.get_mtg!(mtg.id) == mtg
    end

    test "create_mtg/1 with valid data creates a mtg" do
      assert {:ok, %Mtg{} = mtg} = Cards.create_mtg(@valid_attrs)
      assert mtg.set_type == "some set_type"
      assert mtg.power == "some power"
      assert mtg.set_uri == "some set_uri"
      assert mtg.released_at == ~D[2010-04-17]
      assert mtg.scryfall2_uri == "some scryfall2_uri"
      assert mtg.foil == true
      assert mtg.prints_search_uri == "some prints_search_uri"
      assert mtg.tcgplayer_id == 42
      assert mtg.watermark == "some watermark"
      assert mtg.source == "some source"
      assert mtg.digital == true
      assert mtg.scryfall_set_uri == "some scryfall_set_uri"
      assert mtg.artist == "some artist"
      assert mtg.printed_text == "some printed_text"
      assert mtg.story_spotlight == true
      assert mtg.textless == true
      assert mtg.printed_name == "some printed_name"
      assert mtg.arena_id == 42
      assert mtg.full_art == true
      assert mtg.source_uri == "some source_uri"
      assert mtg.promo == true
      assert mtg.rarity == "some rarity"
      assert mtg.variation_of == "some variation_of"
      assert mtg.card_back_id == "some card_back_id"
      assert mtg.illustration_id == "some illustration_id"
      assert mtg.oversized == true
      assert mtg.object == "some object"
      assert mtg.scryfall_id == "some scryfall_id"
      assert mtg.layout == "some layout"
      assert mtg.highres_image == true
      assert mtg.oracle_text == "some oracle_text"
      assert mtg.flavor_text == "some flavor_text"
      assert mtg.set_search_uri == "some set_search_uri"
      assert mtg.previewed_at == ~D[2010-04-17]
      assert mtg.edhrec_rank == 42
      assert mtg.mgto_id == 42
      assert mtg.set_name == "some set_name"
      assert mtg.border_color == "some border_color"
      assert mtg.type_line == "some type_line"
      assert mtg.reserved == true
      assert mtg.rulings_uri == "some rulings_uri"
      assert mtg.frame == "some frame"
      assert mtg.booster == true
      assert mtg.reprint == true
      assert mtg.life_modifier == "some life_modifier"
      assert mtg.scryfall_uri == "some scryfall_uri"
      assert mtg.nonfoil == true
      assert mtg.loyalty == "some loyalty"
      assert mtg.mgto_foil_id == 42
      assert mtg.language_code == "some language_code"
      assert mtg.variation == true
      assert mtg.mana_cost == "some mana_cost"
      assert mtg.toughness == "some toughness"
      assert mtg.name == "some name"
      assert mtg.hand_modifier == "some hand_modifier"
      assert mtg.printed_type_line == "some printed_type_line"
      assert mtg.set == "some set"
      assert mtg.collector_number == "some collector_number"
      assert mtg.cmc == "some cmc"
      assert mtg.oracle_id == "some oracle_id"
    end

    test "create_mtg/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cards.create_mtg(@invalid_attrs)
    end

    test "update_mtg/2 with valid data updates the mtg" do
      mtg = mtg_fixture()
      assert {:ok, %Mtg{} = mtg} = Cards.update_mtg(mtg, @update_attrs)
      assert mtg.set_type == "some updated set_type"
      assert mtg.power == "some updated power"
      assert mtg.set_uri == "some updated set_uri"
      assert mtg.released_at == ~D[2011-05-18]
      assert mtg.scryfall2_uri == "some updated scryfall2_uri"
      assert mtg.foil == false
      assert mtg.prints_search_uri == "some updated prints_search_uri"
      assert mtg.tcgplayer_id == 43
      assert mtg.watermark == "some updated watermark"
      assert mtg.source == "some updated source"
      assert mtg.digital == false
      assert mtg.scryfall_set_uri == "some updated scryfall_set_uri"
      assert mtg.artist == "some updated artist"
      assert mtg.printed_text == "some updated printed_text"
      assert mtg.story_spotlight == false
      assert mtg.textless == false
      assert mtg.printed_name == "some updated printed_name"
      assert mtg.arena_id == 43
      assert mtg.full_art == false
      assert mtg.source_uri == "some updated source_uri"
      assert mtg.promo == false
      assert mtg.rarity == "some updated rarity"
      assert mtg.variation_of == "some updated variation_of"
      assert mtg.card_back_id == "some updated card_back_id"
      assert mtg.illustration_id == "some updated illustration_id"
      assert mtg.oversized == false
      assert mtg.object == "some updated object"
      assert mtg.scryfall_id == "some updated scryfall_id"
      assert mtg.layout == "some updated layout"
      assert mtg.highres_image == false
      assert mtg.oracle_text == "some updated oracle_text"
      assert mtg.flavor_text == "some updated flavor_text"
      assert mtg.set_search_uri == "some updated set_search_uri"
      assert mtg.previewed_at == ~D[2011-05-18]
      assert mtg.edhrec_rank == 43
      assert mtg.mgto_id == 43
      assert mtg.set_name == "some updated set_name"
      assert mtg.border_color == "some updated border_color"
      assert mtg.type_line == "some updated type_line"
      assert mtg.reserved == false
      assert mtg.rulings_uri == "some updated rulings_uri"
      assert mtg.frame == "some updated frame"
      assert mtg.booster == false
      assert mtg.reprint == false
      assert mtg.life_modifier == "some updated life_modifier"
      assert mtg.scryfall_uri == "some updated scryfall_uri"
      assert mtg.nonfoil == false
      assert mtg.loyalty == "some updated loyalty"
      assert mtg.mgto_foil_id == 43
      assert mtg.language_code == "some updated language_code"
      assert mtg.variation == false
      assert mtg.mana_cost == "some updated mana_cost"
      assert mtg.toughness == "some updated toughness"
      assert mtg.name == "some updated name"
      assert mtg.hand_modifier == "some updated hand_modifier"
      assert mtg.printed_type_line == "some updated printed_type_line"
      assert mtg.set == "some updated set"
      assert mtg.collector_number == "some updated collector_number"
      assert mtg.cmc == "some updated cmc"
      assert mtg.oracle_id == "some updated oracle_id"
    end

    test "update_mtg/2 with invalid data returns error changeset" do
      mtg = mtg_fixture()
      assert {:error, %Ecto.Changeset{}} = Cards.update_mtg(mtg, @invalid_attrs)
      assert mtg == Cards.get_mtg!(mtg.id)
    end

    test "delete_mtg/1 deletes the mtg" do
      mtg = mtg_fixture()
      assert {:ok, %Mtg{}} = Cards.delete_mtg(mtg)
      assert_raise Ecto.NoResultsError, fn -> Cards.get_mtg!(mtg.id) end
    end

    test "change_mtg/1 returns a mtg changeset" do
      mtg = mtg_fixture()
      assert %Ecto.Changeset{} = Cards.change_mtg(mtg)
    end
  end

end

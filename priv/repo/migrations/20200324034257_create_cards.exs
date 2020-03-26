defmodule Deckcom.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :arena_id, :integer
      add :scryfall_id, :string
      add :language_code, :string
      add :mgto_id, :integer
      add :mgto_foil_id, :integer
      add :tcgplayer_id, :integer
      add :object, :string
      add :oracle_id, :string
      add :prints_search_uri, :string
      add :rulings_uri, :string
      add :scryfall_uri, :string
      add :scryfall2_uri, :string
      add :cmc, :string
      add :edhrec_rank, :integer
      add :foil, :boolean, default: false, null: false
      add :hand_modifier, :string
      add :layout, :string
      add :life_modifier, :string
      add :loyalty, :string
      add :mana_cost, :string
      add :name, :string
      add :nonfoil, :boolean, default: false, null: false
      add :oracle_text, :string
      add :oversized, :boolean, default: false, null: false
      add :power, :string
      add :reserved, :boolean, default: false, null: false
      add :toughness, :string
      add :type_line, :string
      add :artist, :string
      add :booster, :boolean, default: false, null: false
      add :border_color, :string
      add :card_back_id, :string
      add :collector_number, :string
      add :digital, :boolean, default: false, null: false
      add :flavor_text, :string
      add :frame, :string
      add :full_art, :boolean, default: false, null: false
      add :highres_image, :boolean, default: false, null: false
      add :illustration_id, :string
      add :printed_name, :string
      add :printed_text, :string
      add :printed_type_line, :string
      add :promo, :boolean, default: false, null: false
      add :rarity, :string
      add :released_at, :date
      add :reprint, :boolean, default: false, null: false
      add :scryfall_set_uri, :string
      add :set_name, :string
      add :set_search_uri, :string
      add :set_type, :string
      add :set_uri, :string
      add :set, :string
      add :story_spotlight, :boolean, default: false, null: false
      add :textless, :boolean, default: false, null: false
      add :variation, :boolean, default: false, null: false
      add :variation_of, :string
      add :watermark, :string
      add :previewed_at, :date
      add :source_uri, :string
      add :source, :string
      add :multiverse_ids, {:array, :integer}
      add :all_parts, {:array, :integer}
      add :card_faces, {:array, :integer}
      add :colors, {:array, :string}
      add :color_identity, {:array, :string}
      add :color_indicator, {:array, :string}
      add :legalities, {:array, :string}
      add :frame_effects, {:array, :string}
      add :games, {:array, :string}
      add :image_uris, {:array, :string}
      add :prices, {:array, :string}
      add :promo_types, {:array, :string}
      add :purchase_uris, {:array, :string}
      add :related_uris, {:array, :string}
      
      timestamps()
    end

  end
end

defmodule Deckcom.Cards.Mtg do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cards" do
    field :set_type, :string
    field :power, :string
    field :set_uri, :string
    field :released_at, :string
    field :scryfall2_uri, :string
    field :foil, :boolean, default: false
    field :prints_search_uri, :string
    field :tcgplayer_id, :integer
    field :watermark, :string
    field :source, :string
    field :digital, :boolean, default: false
    field :scryfall_set_uri, :string
    field :artist, :string
    field :printed_text, :string
    field :story_spotlight, :boolean, default: false
    field :textless, :boolean, default: false
    field :printed_name, :string
    field :arena_id, :integer
    field :full_art, :boolean, default: false
    field :source_uri, :string
    field :promo, :boolean, default: false
    field :rarity, :string
    field :variation_of, :string
    field :card_back_id, :string
    field :illustration_id, :string
    field :oversized, :boolean, default: false
    field :object, :string
    field :scryfall_id, :string
    field :layout, :string
    field :highres_image, :boolean, default: false
    field :oracle_text, :string
    field :flavor_text, :string
    field :set_search_uri, :string
    field :previewed_at, :date
    field :edhrec_rank, :integer
    field :mgto_id, :integer
    field :set_name, :string
    field :border_color, :string
    field :type_line, :string
    field :reserved, :boolean, default: false
    field :rulings_uri, :string
    field :frame, :string
    field :booster, :boolean, default: false
    field :reprint, :boolean, default: false
    field :life_modifier, :string
    field :scryfall_uri, :string
    field :nonfoil, :boolean, default: false
    field :loyalty, :string
    field :mgto_foil_id, :integer
    field :language_code, :string
    field :variation, :boolean, default: false
    field :mana_cost, :string
    field :toughness, :string
    field :name, :string
    field :hand_modifier, :string
    field :printed_type_line, :string
    field :set, :string
    field :collector_number, :string
    field :cmc, :string
    field :oracle_id, :string
    field :multiverse_ids, {:array, :integer}
    field :all_parts, {:array, :integer}
    field :card_faces, {:array, :integer}
    field :colors, {:array, :string}
    field :color_identity, {:array, :string}
    field :color_indicator, {:array, :string}
    field :legalities, {:array, :string}
    field :frame_effects, {:array, :string}
    field :games, {:array, :string}
    field :image_uris, {:array, :string}
    field :prices, {:array, :string}
    field :promo_types, {:array, :string}
    field :purchase_uris, {:array, :string}
    field :related_uris, {:array, :string}

    timestamps()
  end

  @doc false
  def changeset(mtg, attrs) do
    mtg
    |> cast(attrs, [:arena_id, :scryfall_id, :language_code, :mgto_id, :mgto_foil_id, :tcgplayer_id, :object, :oracle_id, :prints_search_uri,
     :rulings_uri, :scryfall_uri, :scryfall2_uri, :cmc, :edhrec_rank, :foil, :hand_modifier, :layout, :life_modifier, :loyalty, :mana_cost,
      :name, :nonfoil, :oracle_text, :oversized, :power, :reserved, :toughness, :type_line, :artist, :booster, :border_color, :card_back_id,
       :collector_number, :digital, :flavor_text, :frame, :full_art, :highres_image, :illustration_id, :printed_name, :printed_text,
        :printed_type_line, :promo, :rarity, :released_at, :reprint, :scryfall_set_uri, :set_name, :set_search_uri, :set_type, :set_uri, :set,
         :story_spotlight, :textless, :variation, :variation_of, :watermark, :previewed_at, :source_uri, :source, :multiverse_ids, :all_parts,
          :card_faces, :colors, :color_identity, :color_indicator, :legalities, :frame_effects, :games, :image_uris, :prices, :promo_types,
           :purchase_uris, :related_uris])
    |> validate_required([:name])
    #Take what you can get approach, so if an error pops up while running database merges, we can easily avoid errors within our database
    #|> validate_required([:arena_id, :scryfall_id, :language_code, :mgto_id, :mgto_foil_id, :tcgplayer_id, :object, :oracle_id, :prints_search_uri,
    # :rulings_uri, :scryfall_uri, :scryfall2_uri, :cmc, :edhrec_rank, :foil, :hand_modifier, :layout, :life_modifier, :loyalty, :mana_cost, :name,
    # :nonfoil, :oracle_text, :oversized, :power, :reserved, :toughness, :type_line, :artist, :booster, :border_color, :card_back_id, :collector_number,
    # :digital, :flavor_text, :frame, :full_art, :highres_image, :illustration_id, :printed_name, :printed_text, :printed_type_line, :promo, :rarity,
    # :released_at, :reprint, :scryfall_set_uri, :set_name, :set_search_uri, :set_type, :set_uri, :set, :story_spotlight, :textless, :variation, :variation_of,
    # :watermark, :previewed_at, :source_uri, :source])
  end
end

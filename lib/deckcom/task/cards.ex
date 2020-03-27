defmodule Deckcom.Task.Cards do
    def start_card_db_copy() do
      page = 1
      n = HTTPoison.request(
        "GET",
        "https://api.scryfall.com/cards?page=#{page}",
        "",
        [
          
          ],
        [       
          ]
            )
        |> case do
          {:ok, %{body: raw, status_code: code}} -> 
            {code, raw}
            {:error, %{reason: reason}} -> {:error, reason}
        end
        |> (fn {ok, body} ->
          IO.puts inspect body
          body
          |> Poison.decode(keys: :atoms)
          |> case do
            {:ok, parsed} -> 
            zn = Map.keys(parsed)
            if zn === [:error] do
              IO.puts inspect "Parse Error"
            else 
              data = Enum.at(elem(Map.fetch(parsed, :data), 1), 0)
              dataKeys = Map.keys(data)
              IO.puts inspect dataKeys
              name = elem(Map.fetch(data, :name), 1)
              IO.puts inspect name
              colors = []
              case Map.fetch(data, :colors) do
                :error ->
                  colors = []
                :ok ->
                  colors = elem(Map.fetch(data, :colors), 1)
                {:ok, _} ->
                  colors = elem(Map.fetch(data, :colors), 1)
              end
              image_uris = []
              case Map.fetch(data, :image_uris) do
                :error ->
                  image_uris = []
                :ok ->
                  image_uris = [elem(Map.fetch(elem(Map.fetch(data, :image_uris), 1), :normal), 1)]
                {:ok, _} ->
                  image_uris = [elem(Map.fetch(elem(Map.fetch(data, :image_uris), 1), :normal), 1)]
              end
              sid = elem(Map.fetch(data, :id), 1)
              #exists = Deckcom.Cards.get_card(scryfall_id: sid)
              #IO.puts inspect exists
              case Deckcom.Cards.get_card(scryfall_id: sid) do
                :ok ->
                  card = Deckcom.Cards.get_card(scryfall_id: sid)
                  Deckcom.Repo.get_by(Deckcom.Cards.Mtg, id: card.id)
                  |> Ecto.Changeset.change(%{
                    #arena_id: elem(Map.fetch(data, :arena_id), 1), 
                    scryfall_id: elem(Map.fetch(data, :id), 1),
                    language_code: elem(Map.fetch(data, :lang), 1),
                    #mgto_id: elem(Map.fetch(data, :mtgo_id), 1),
                    #mgto_foil_id: elem(Map.fetch(data, :mtgo_foil_id), 1),
                    #tcgplayer_id: elem(Map.fetch(data, :tcgplayer_id), 1),
                    object: elem(Map.fetch(data, :object), 1),
                    oracle_id: elem(Map.fetch(data, :oracle_id), 1),
                    prints_search_uri: elem(Map.fetch(data, :prints_search_uri), 1),
                    rulings_uri: elem(Map.fetch(data, :rulings_uri), 1),
                    scryfall_uri: elem(Map.fetch(data, :scryfall_uri), 1),
                    scryfall2_uri: elem(Map.fetch(data, :uri), 1),
                    cmc: "#{elem(Map.fetch(data, :cmc), 1)}",
                    #edhrec_rank: elem(Map.fetch(data, :edhrec_rank), 1),
                    foil: elem(Map.fetch(data, :foil), 1),
                    #hand_modifier: elem(Map.fetch(data, :hand_modifier), 1),
                    layout: elem(Map.fetch(data, :layout), 1),
                    #life_modifier: elem(Map.fetch(data, :life_modifier), 1),
                    #loyalty: elem(Map.fetch(data, :loyalty), 1),
                    #mana_cost: elem(Map.fetch(data, :mana_cost), 1),
                    name: name,
                    nonfoil: elem(Map.fetch(data, :nonfoil), 1),
                    #oracle_text: elem(Map.fetch(data, :oracle_text), 1),
                    oversized: elem(Map.fetch(data, :oversized), 1),
                    #power: elem(Map.fetch(data, :power), 1),
                    reserved: elem(Map.fetch(data, :reserved), 1),
                    #toughness: elem(Map.fetch(data, :toughness), 1),
                    type_line: elem(Map.fetch(data, :type_line), 1),
                    #artist: elem(Map.fetch(data, :artist), 1),
                    booster: elem(Map.fetch(data, :booster), 1),
                    border_color: elem(Map.fetch(data, :border_color), 1),
                    card_back_id: elem(Map.fetch(data, :card_back_id), 1),
                    collector_number: elem(Map.fetch(data, :collector_number), 1),
                    digital: elem(Map.fetch(data, :digital), 1),
                    #flavor_text: elem(Map.fetch(data, :flavor_text), 1),
                    frame: elem(Map.fetch(data, :frame), 1),
                    full_art: elem(Map.fetch(data, :full_art), 1),
                    highres_image: elem(Map.fetch(data, :highres_image), 1),
                    #illustration_id: elem(Map.fetch(data, :illustration_id), 1),
                    #printed_name: elem(Map.fetch(data, :printed_name), 1),
                    #printed_text: elem(Map.fetch(data, :printed_text), 1),
                    #printed_type_line: elem(Map.fetch(data, :printed_type_line), 1),
                    promo: elem(Map.fetch(data, :promo), 1),
                    rarity: elem(Map.fetch(data, :rarity), 1),
                    released_at: elem(Map.fetch(data, :released_at), 1),
                    reprint: elem(Map.fetch(data, :reprint), 1),
                    scryfall_set_uri: elem(Map.fetch(data, :scryfall_set_uri), 1),
                    set_name: elem(Map.fetch(data, :set_name), 1),
                    set_search_uri: elem(Map.fetch(data, :set_search_uri), 1),
                    set_type: elem(Map.fetch(data, :set_type), 1),
                    set_uri: elem(Map.fetch(data, :set_uri), 1),
                    set: elem(Map.fetch(data, :set), 1),
                    story_spotlight: elem(Map.fetch(data, :story_spotlight), 1),
                    textless: elem(Map.fetch(data, :textless), 1),
                    variation: elem(Map.fetch(data, :variation), 1),
                    #variation_of: elem(Map.fetch(data, :variation_of), 1),
                    #watermark: elem(Map.fetch(data, :watermark), 1),
                    #previewed_at: elem(Map.fetch(data, :previewed_at), 1),
                    #source_uri: elem(Map.fetch(data, :source_uri), 1),
                    #source: elem(Map.fetch(data, :source), 1),
                    colors: colors,
                    color_identity: elem(Map.fetch(data, :color_identity), 1),
                    #color_indicator: elem(Map.fetch(data, :color_indicator), 1),
                    #REVISIT#legalities: "#{elem(Map.fetch(data, :legalities), 1)}",
                    #frame_effects: elem(Map.fetch(data, :frame_effects), 1),
                    games: elem(Map.fetch(data, :games), 1),
                    image_uris: image_uris
                    #REVISIT#prices: elem(Map.fetch(data, :prices), 1),
                    #promo_types: elem(Map.fetch(data, :promo_types), 1),
                    #REVISIT#purchase_uris: elem(Map.fetch(data, :purchase_uris), 1),
                    #REVISIT#related_uris: elem(Map.fetch(data, :related_uris), 1)
                    })
                  |> Deckcom.Repo.update()
                  nil ->
                    case Deckcom.Cards.create_mtg(%{
                      #arena_id: elem(Map.fetch(data, :arena_id), 1), 
                      scryfall_id: elem(Map.fetch(data, :id), 1),
                      language_code: elem(Map.fetch(data, :lang), 1),
                      #mgto_id: elem(Map.fetch(data, :mtgo_id), 1),
                      #mgto_foil_id: elem(Map.fetch(data, :mtgo_foil_id), 1),
                      #tcgplayer_id: elem(Map.fetch(data, :tcgplayer_id), 1),
                      object: elem(Map.fetch(data, :object), 1),
                      oracle_id: elem(Map.fetch(data, :oracle_id), 1),
                      prints_search_uri: elem(Map.fetch(data, :prints_search_uri), 1),
                      rulings_uri: elem(Map.fetch(data, :rulings_uri), 1),
                      scryfall_uri: elem(Map.fetch(data, :scryfall_uri), 1),
                      scryfall2_uri: elem(Map.fetch(data, :uri), 1),
                      cmc: "#{elem(Map.fetch(data, :cmc), 1)}",
                      #edhrec_rank: elem(Map.fetch(data, :edhrec_rank), 1),
                      foil: elem(Map.fetch(data, :foil), 1),
                      #hand_modifier: elem(Map.fetch(data, :hand_modifier), 1),
                      layout: elem(Map.fetch(data, :layout), 1),
                      #life_modifier: elem(Map.fetch(data, :life_modifier), 1),
                      #loyalty: elem(Map.fetch(data, :loyalty), 1),
                      #mana_cost: elem(Map.fetch(data, :mana_cost), 1),
                      name: name,
                      nonfoil: elem(Map.fetch(data, :nonfoil), 1),
                      #oracle_text: elem(Map.fetch(data, :oracle_text), 1),
                      oversized: elem(Map.fetch(data, :oversized), 1),
                      #power: elem(Map.fetch(data, :power), 1),
                      reserved: elem(Map.fetch(data, :reserved), 1),
                      #toughness: elem(Map.fetch(data, :toughness), 1),
                      type_line: elem(Map.fetch(data, :type_line), 1),
                      #artist: elem(Map.fetch(data, :artist), 1),
                      booster: elem(Map.fetch(data, :booster), 1),
                      border_color: elem(Map.fetch(data, :border_color), 1),
                      card_back_id: elem(Map.fetch(data, :card_back_id), 1),
                      collector_number: elem(Map.fetch(data, :collector_number), 1),
                      digital: elem(Map.fetch(data, :digital), 1),
                      #flavor_text: elem(Map.fetch(data, :flavor_text), 1),
                      frame: elem(Map.fetch(data, :frame), 1),
                      full_art: elem(Map.fetch(data, :full_art), 1),
                      highres_image: elem(Map.fetch(data, :highres_image), 1),
                      #illustration_id: elem(Map.fetch(data, :illustration_id), 1),
                      #printed_name: elem(Map.fetch(data, :printed_name), 1),
                      #printed_text: elem(Map.fetch(data, :printed_text), 1),
                      #printed_type_line: elem(Map.fetch(data, :printed_type_line), 1),
                      promo: elem(Map.fetch(data, :promo), 1),
                      rarity: elem(Map.fetch(data, :rarity), 1),
                      released_at: elem(Map.fetch(data, :released_at), 1),
                      reprint: elem(Map.fetch(data, :reprint), 1),
                      scryfall_set_uri: elem(Map.fetch(data, :scryfall_set_uri), 1),
                      set_name: elem(Map.fetch(data, :set_name), 1),
                      set_search_uri: elem(Map.fetch(data, :set_search_uri), 1),
                      set_type: elem(Map.fetch(data, :set_type), 1),
                      set_uri: elem(Map.fetch(data, :set_uri), 1),
                      set: elem(Map.fetch(data, :set), 1),
                      story_spotlight: elem(Map.fetch(data, :story_spotlight), 1),
                      textless: elem(Map.fetch(data, :textless), 1),
                      variation: elem(Map.fetch(data, :variation), 1),
                      #variation_of: elem(Map.fetch(data, :variation_of), 1),
                      #watermark: elem(Map.fetch(data, :watermark), 1),
                      #previewed_at: elem(Map.fetch(data, :previewed_at), 1),
                      #source_uri: elem(Map.fetch(data, :source_uri), 1),
                      #source: elem(Map.fetch(data, :source), 1),
                      colors: colors,
                      color_identity: elem(Map.fetch(data, :color_identity), 1),
                      #color_indicator: elem(Map.fetch(data, :color_indicator), 1),
                      #REVISIT#legalities: "#{elem(Map.fetch(data, :legalities), 1)}",
                      #frame_effects: elem(Map.fetch(data, :frame_effects), 1),
                      games: elem(Map.fetch(data, :games), 1),
                      image_uris: image_uris
                      #REVISIT#prices: elem(Map.fetch(data, :prices), 1),
                      #promo_types: elem(Map.fetch(data, :promo_types), 1),
                      #REVISIT#purchase_uris: elem(Map.fetch(data, :purchase_uris), 1),
                      #REVISIT#related_uris: elem(Map.fetch(data, :related_uris), 1)
                    
                  }) do
                      {:ok, _} ->
                        "CARD COPIED"
                      {:error, _} ->
                        "CARD NOT COPIED"
                  end
                  _ ->
                    card = Deckcom.Cards.get_card(scryfall_id: sid)
                    Deckcom.Repo.get_by(Deckcom.Cards.Mtg, id: card.id)
                    |> Ecto.Changeset.change(%{
                      #arena_id: elem(Map.fetch(data, :arena_id), 1), 
                      scryfall_id: elem(Map.fetch(data, :id), 1),
                      language_code: elem(Map.fetch(data, :lang), 1),
                      #mgto_id: elem(Map.fetch(data, :mtgo_id), 1),
                      #mgto_foil_id: elem(Map.fetch(data, :mtgo_foil_id), 1),
                      #tcgplayer_id: elem(Map.fetch(data, :tcgplayer_id), 1),
                      object: elem(Map.fetch(data, :object), 1),
                      oracle_id: elem(Map.fetch(data, :oracle_id), 1),
                      prints_search_uri: elem(Map.fetch(data, :prints_search_uri), 1),
                      rulings_uri: elem(Map.fetch(data, :rulings_uri), 1),
                      scryfall_uri: elem(Map.fetch(data, :scryfall_uri), 1),
                      scryfall2_uri: elem(Map.fetch(data, :uri), 1),
                      cmc: "#{elem(Map.fetch(data, :cmc), 1)}",
                      #edhrec_rank: elem(Map.fetch(data, :edhrec_rank), 1),
                      foil: elem(Map.fetch(data, :foil), 1),
                      #hand_modifier: elem(Map.fetch(data, :hand_modifier), 1),
                      layout: elem(Map.fetch(data, :layout), 1),
                      #life_modifier: elem(Map.fetch(data, :life_modifier), 1),
                      #loyalty: elem(Map.fetch(data, :loyalty), 1),
                      #mana_cost: elem(Map.fetch(data, :mana_cost), 1),
                      name: name,
                      nonfoil: elem(Map.fetch(data, :nonfoil), 1),
                      #oracle_text: elem(Map.fetch(data, :oracle_text), 1),
                      oversized: elem(Map.fetch(data, :oversized), 1),
                      #power: elem(Map.fetch(data, :power), 1),
                      reserved: elem(Map.fetch(data, :reserved), 1),
                      #toughness: elem(Map.fetch(data, :toughness), 1),
                      type_line: elem(Map.fetch(data, :type_line), 1),
                      #artist: elem(Map.fetch(data, :artist), 1),
                      booster: elem(Map.fetch(data, :booster), 1),
                      border_color: elem(Map.fetch(data, :border_color), 1),
                      card_back_id: elem(Map.fetch(data, :card_back_id), 1),
                      collector_number: elem(Map.fetch(data, :collector_number), 1),
                      digital: elem(Map.fetch(data, :digital), 1),
                      #flavor_text: elem(Map.fetch(data, :flavor_text), 1),
                      frame: elem(Map.fetch(data, :frame), 1),
                      full_art: elem(Map.fetch(data, :full_art), 1),
                      highres_image: elem(Map.fetch(data, :highres_image), 1),
                      #illustration_id: elem(Map.fetch(data, :illustration_id), 1),
                      #printed_name: elem(Map.fetch(data, :printed_name), 1),
                      #printed_text: elem(Map.fetch(data, :printed_text), 1),
                      #printed_type_line: elem(Map.fetch(data, :printed_type_line), 1),
                      promo: elem(Map.fetch(data, :promo), 1),
                      rarity: elem(Map.fetch(data, :rarity), 1),
                      released_at: elem(Map.fetch(data, :released_at), 1),
                      reprint: elem(Map.fetch(data, :reprint), 1),
                      scryfall_set_uri: elem(Map.fetch(data, :scryfall_set_uri), 1),
                      set_name: elem(Map.fetch(data, :set_name), 1),
                      set_search_uri: elem(Map.fetch(data, :set_search_uri), 1),
                      set_type: elem(Map.fetch(data, :set_type), 1),
                      set_uri: elem(Map.fetch(data, :set_uri), 1),
                      set: elem(Map.fetch(data, :set), 1),
                      story_spotlight: elem(Map.fetch(data, :story_spotlight), 1),
                      textless: elem(Map.fetch(data, :textless), 1),
                      variation: elem(Map.fetch(data, :variation), 1),
                      #variation_of: elem(Map.fetch(data, :variation_of), 1),
                      #watermark: elem(Map.fetch(data, :watermark), 1),
                      #previewed_at: elem(Map.fetch(data, :previewed_at), 1),
                      #source_uri: elem(Map.fetch(data, :source_uri), 1),
                      #source: elem(Map.fetch(data, :source), 1),
                      colors: colors,
                      color_identity: elem(Map.fetch(data, :color_identity), 1),
                      #color_indicator: elem(Map.fetch(data, :color_indicator), 1),
                      #REVISIT#legalities: "#{elem(Map.fetch(data, :legalities), 1)}",
                      #frame_effects: elem(Map.fetch(data, :frame_effects), 1),
                      games: elem(Map.fetch(data, :games), 1),
                      image_uris: image_uris
                      #REVISIT#prices: elem(Map.fetch(data, :prices), 1),
                      #promo_types: elem(Map.fetch(data, :promo_types), 1),
                      #REVISIT#purchase_uris: elem(Map.fetch(data, :purchase_uris), 1),
                      #REVISIT#related_uris: elem(Map.fetch(data, :related_uris), 1)
                      })
                    |> Deckcom.Repo.update()
              end
              #IO.puts inspect elem(Map.fetch(data, :image_uris), 1)
              
              more = elem(Map.fetch(parsed, :has_more), 1)
              IO.puts inspect more
              next = elem(Map.fetch(parsed, :next_page), 1)
              IO.puts inspect next
              if more === true do
                :timer.sleep(500)
                next_page_copy(next)
              end
            end
            #IO.puts inspect zn
          end
      end).() 
    end

    def continue_card_db_copy(page) do
      n = HTTPoison.request(
        "GET",
        "https://api.scryfall.com/cards?page=#{page}",
        "",
        [
          
          ],
        [       
          ]
            )
        |> case do
          {:ok, %{body: raw, status_code: code}} -> 
            {code, raw}
            {:error, %{reason: reason}} -> {:error, reason}
        end
        |> (fn {ok, body} ->
          IO.puts inspect body
          body
          |> Poison.decode(keys: :atoms)
          |> case do
            {:ok, parsed} -> 
            zn = Map.keys(parsed)
            if zn === [:error] do
              IO.puts inspect "Parse Error"
            else 
              data = Enum.at(elem(Map.fetch(parsed, :data), 1), 0)
              dataKeys = Map.keys(data)
              IO.puts inspect dataKeys
              name = elem(Map.fetch(data, :name), 1)
              IO.puts inspect name
              colors = []
              case Map.fetch(data, :colors) do
                :error ->
                  colors = []
                :ok ->
                  colors = elem(Map.fetch(data, :colors), 1)
                {:ok, _} ->
                  colors = elem(Map.fetch(data, :colors), 1)
              end
              image_uris = []
              case Map.fetch(data, :image_uris) do
                :error ->
                  image_uris = []
                :ok ->
                  image_uris = [elem(Map.fetch(elem(Map.fetch(data, :image_uris), 1), :normal), 1)]
                {:ok, _} ->
                  image_uris = [elem(Map.fetch(elem(Map.fetch(data, :image_uris), 1), :normal), 1)]
              end
              sid = elem(Map.fetch(data, :id), 1)
              #exists = Deckcom.Cards.get_card(scryfall_id: sid)
              #IO.puts inspect exists
              case Deckcom.Cards.get_card(scryfall_id: sid) do
                :ok ->
                  card = Deckcom.Cards.get_card(scryfall_id: sid)
                  Deckcom.Repo.get_by(Deckcom.Cards.Mtg, id: card.id)
                  |> Ecto.Changeset.change(%{
                    #arena_id: elem(Map.fetch(data, :arena_id), 1), 
                    scryfall_id: elem(Map.fetch(data, :id), 1),
                    language_code: elem(Map.fetch(data, :lang), 1),
                    #mgto_id: elem(Map.fetch(data, :mtgo_id), 1),
                    #mgto_foil_id: elem(Map.fetch(data, :mtgo_foil_id), 1),
                    #tcgplayer_id: elem(Map.fetch(data, :tcgplayer_id), 1),
                    object: elem(Map.fetch(data, :object), 1),
                    oracle_id: elem(Map.fetch(data, :oracle_id), 1),
                    prints_search_uri: elem(Map.fetch(data, :prints_search_uri), 1),
                    rulings_uri: elem(Map.fetch(data, :rulings_uri), 1),
                    scryfall_uri: elem(Map.fetch(data, :scryfall_uri), 1),
                    scryfall2_uri: elem(Map.fetch(data, :uri), 1),
                    cmc: "#{elem(Map.fetch(data, :cmc), 1)}",
                    #edhrec_rank: elem(Map.fetch(data, :edhrec_rank), 1),
                    foil: elem(Map.fetch(data, :foil), 1),
                    #hand_modifier: elem(Map.fetch(data, :hand_modifier), 1),
                    layout: elem(Map.fetch(data, :layout), 1),
                    #life_modifier: elem(Map.fetch(data, :life_modifier), 1),
                    #loyalty: elem(Map.fetch(data, :loyalty), 1),
                    #mana_cost: elem(Map.fetch(data, :mana_cost), 1),
                    name: name,
                    nonfoil: elem(Map.fetch(data, :nonfoil), 1),
                    #oracle_text: elem(Map.fetch(data, :oracle_text), 1),
                    oversized: elem(Map.fetch(data, :oversized), 1),
                    #power: elem(Map.fetch(data, :power), 1),
                    reserved: elem(Map.fetch(data, :reserved), 1),
                    #toughness: elem(Map.fetch(data, :toughness), 1),
                    type_line: elem(Map.fetch(data, :type_line), 1),
                    #artist: elem(Map.fetch(data, :artist), 1),
                    booster: elem(Map.fetch(data, :booster), 1),
                    border_color: elem(Map.fetch(data, :border_color), 1),
                    card_back_id: elem(Map.fetch(data, :card_back_id), 1),
                    collector_number: elem(Map.fetch(data, :collector_number), 1),
                    digital: elem(Map.fetch(data, :digital), 1),
                    #flavor_text: elem(Map.fetch(data, :flavor_text), 1),
                    frame: elem(Map.fetch(data, :frame), 1),
                    full_art: elem(Map.fetch(data, :full_art), 1),
                    highres_image: elem(Map.fetch(data, :highres_image), 1),
                    #illustration_id: elem(Map.fetch(data, :illustration_id), 1),
                    #printed_name: elem(Map.fetch(data, :printed_name), 1),
                    #printed_text: elem(Map.fetch(data, :printed_text), 1),
                    #printed_type_line: elem(Map.fetch(data, :printed_type_line), 1),
                    promo: elem(Map.fetch(data, :promo), 1),
                    rarity: elem(Map.fetch(data, :rarity), 1),
                    released_at: elem(Map.fetch(data, :released_at), 1),
                    reprint: elem(Map.fetch(data, :reprint), 1),
                    scryfall_set_uri: elem(Map.fetch(data, :scryfall_set_uri), 1),
                    set_name: elem(Map.fetch(data, :set_name), 1),
                    set_search_uri: elem(Map.fetch(data, :set_search_uri), 1),
                    set_type: elem(Map.fetch(data, :set_type), 1),
                    set_uri: elem(Map.fetch(data, :set_uri), 1),
                    set: elem(Map.fetch(data, :set), 1),
                    story_spotlight: elem(Map.fetch(data, :story_spotlight), 1),
                    textless: elem(Map.fetch(data, :textless), 1),
                    variation: elem(Map.fetch(data, :variation), 1),
                    #variation_of: elem(Map.fetch(data, :variation_of), 1),
                    #watermark: elem(Map.fetch(data, :watermark), 1),
                    #previewed_at: elem(Map.fetch(data, :previewed_at), 1),
                    #source_uri: elem(Map.fetch(data, :source_uri), 1),
                    #source: elem(Map.fetch(data, :source), 1),
                    colors: colors,
                    color_identity: elem(Map.fetch(data, :color_identity), 1),
                    #color_indicator: elem(Map.fetch(data, :color_indicator), 1),
                    #REVISIT#legalities: "#{elem(Map.fetch(data, :legalities), 1)}",
                    #frame_effects: elem(Map.fetch(data, :frame_effects), 1),
                    games: elem(Map.fetch(data, :games), 1),
                    image_uris: image_uris
                    #REVISIT#prices: elem(Map.fetch(data, :prices), 1),
                    #promo_types: elem(Map.fetch(data, :promo_types), 1),
                    #REVISIT#purchase_uris: elem(Map.fetch(data, :purchase_uris), 1),
                    #REVISIT#related_uris: elem(Map.fetch(data, :related_uris), 1)
                    })
                  |> Deckcom.Repo.update()
                  nil ->
                    case Deckcom.Cards.create_mtg(%{
                      #arena_id: elem(Map.fetch(data, :arena_id), 1), 
                      scryfall_id: elem(Map.fetch(data, :id), 1),
                      language_code: elem(Map.fetch(data, :lang), 1),
                      #mgto_id: elem(Map.fetch(data, :mtgo_id), 1),
                      #mgto_foil_id: elem(Map.fetch(data, :mtgo_foil_id), 1),
                      #tcgplayer_id: elem(Map.fetch(data, :tcgplayer_id), 1),
                      object: elem(Map.fetch(data, :object), 1),
                      oracle_id: elem(Map.fetch(data, :oracle_id), 1),
                      prints_search_uri: elem(Map.fetch(data, :prints_search_uri), 1),
                      rulings_uri: elem(Map.fetch(data, :rulings_uri), 1),
                      scryfall_uri: elem(Map.fetch(data, :scryfall_uri), 1),
                      scryfall2_uri: elem(Map.fetch(data, :uri), 1),
                      cmc: "#{elem(Map.fetch(data, :cmc), 1)}",
                      #edhrec_rank: elem(Map.fetch(data, :edhrec_rank), 1),
                      foil: elem(Map.fetch(data, :foil), 1),
                      #hand_modifier: elem(Map.fetch(data, :hand_modifier), 1),
                      layout: elem(Map.fetch(data, :layout), 1),
                      #life_modifier: elem(Map.fetch(data, :life_modifier), 1),
                      #loyalty: elem(Map.fetch(data, :loyalty), 1),
                      #mana_cost: elem(Map.fetch(data, :mana_cost), 1),
                      name: name,
                      nonfoil: elem(Map.fetch(data, :nonfoil), 1),
                      #oracle_text: elem(Map.fetch(data, :oracle_text), 1),
                      oversized: elem(Map.fetch(data, :oversized), 1),
                      #power: elem(Map.fetch(data, :power), 1),
                      reserved: elem(Map.fetch(data, :reserved), 1),
                      #toughness: elem(Map.fetch(data, :toughness), 1),
                      type_line: elem(Map.fetch(data, :type_line), 1),
                      #artist: elem(Map.fetch(data, :artist), 1),
                      booster: elem(Map.fetch(data, :booster), 1),
                      border_color: elem(Map.fetch(data, :border_color), 1),
                      card_back_id: elem(Map.fetch(data, :card_back_id), 1),
                      collector_number: elem(Map.fetch(data, :collector_number), 1),
                      digital: elem(Map.fetch(data, :digital), 1),
                      #flavor_text: elem(Map.fetch(data, :flavor_text), 1),
                      frame: elem(Map.fetch(data, :frame), 1),
                      full_art: elem(Map.fetch(data, :full_art), 1),
                      highres_image: elem(Map.fetch(data, :highres_image), 1),
                      #illustration_id: elem(Map.fetch(data, :illustration_id), 1),
                      #printed_name: elem(Map.fetch(data, :printed_name), 1),
                      #printed_text: elem(Map.fetch(data, :printed_text), 1),
                      #printed_type_line: elem(Map.fetch(data, :printed_type_line), 1),
                      promo: elem(Map.fetch(data, :promo), 1),
                      rarity: elem(Map.fetch(data, :rarity), 1),
                      released_at: elem(Map.fetch(data, :released_at), 1),
                      reprint: elem(Map.fetch(data, :reprint), 1),
                      scryfall_set_uri: elem(Map.fetch(data, :scryfall_set_uri), 1),
                      set_name: elem(Map.fetch(data, :set_name), 1),
                      set_search_uri: elem(Map.fetch(data, :set_search_uri), 1),
                      set_type: elem(Map.fetch(data, :set_type), 1),
                      set_uri: elem(Map.fetch(data, :set_uri), 1),
                      set: elem(Map.fetch(data, :set), 1),
                      story_spotlight: elem(Map.fetch(data, :story_spotlight), 1),
                      textless: elem(Map.fetch(data, :textless), 1),
                      variation: elem(Map.fetch(data, :variation), 1),
                      #variation_of: elem(Map.fetch(data, :variation_of), 1),
                      #watermark: elem(Map.fetch(data, :watermark), 1),
                      #previewed_at: elem(Map.fetch(data, :previewed_at), 1),
                      #source_uri: elem(Map.fetch(data, :source_uri), 1),
                      #source: elem(Map.fetch(data, :source), 1),
                      colors: colors,
                      color_identity: elem(Map.fetch(data, :color_identity), 1),
                      #color_indicator: elem(Map.fetch(data, :color_indicator), 1),
                      #REVISIT#legalities: "#{elem(Map.fetch(data, :legalities), 1)}",
                      #frame_effects: elem(Map.fetch(data, :frame_effects), 1),
                      games: elem(Map.fetch(data, :games), 1),
                      image_uris: image_uris
                      #REVISIT#prices: elem(Map.fetch(data, :prices), 1),
                      #promo_types: elem(Map.fetch(data, :promo_types), 1),
                      #REVISIT#purchase_uris: elem(Map.fetch(data, :purchase_uris), 1),
                      #REVISIT#related_uris: elem(Map.fetch(data, :related_uris), 1)
                    
                  }) do
                      {:ok, _} ->
                        "CARD COPIED"
                      {:error, _} ->
                        "CARD NOT COPIED"
                  end
                  _ ->
                    card = Deckcom.Cards.get_card(scryfall_id: sid)
                    Deckcom.Repo.get_by(Deckcom.Cards.Mtg, id: card.id)
                    |> Ecto.Changeset.change(%{
                      #arena_id: elem(Map.fetch(data, :arena_id), 1), 
                      scryfall_id: elem(Map.fetch(data, :id), 1),
                      language_code: elem(Map.fetch(data, :lang), 1),
                      #mgto_id: elem(Map.fetch(data, :mtgo_id), 1),
                      #mgto_foil_id: elem(Map.fetch(data, :mtgo_foil_id), 1),
                      #tcgplayer_id: elem(Map.fetch(data, :tcgplayer_id), 1),
                      object: elem(Map.fetch(data, :object), 1),
                      oracle_id: elem(Map.fetch(data, :oracle_id), 1),
                      prints_search_uri: elem(Map.fetch(data, :prints_search_uri), 1),
                      rulings_uri: elem(Map.fetch(data, :rulings_uri), 1),
                      scryfall_uri: elem(Map.fetch(data, :scryfall_uri), 1),
                      scryfall2_uri: elem(Map.fetch(data, :uri), 1),
                      cmc: "#{elem(Map.fetch(data, :cmc), 1)}",
                      #edhrec_rank: elem(Map.fetch(data, :edhrec_rank), 1),
                      foil: elem(Map.fetch(data, :foil), 1),
                      #hand_modifier: elem(Map.fetch(data, :hand_modifier), 1),
                      layout: elem(Map.fetch(data, :layout), 1),
                      #life_modifier: elem(Map.fetch(data, :life_modifier), 1),
                      #loyalty: elem(Map.fetch(data, :loyalty), 1),
                      #mana_cost: elem(Map.fetch(data, :mana_cost), 1),
                      name: name,
                      nonfoil: elem(Map.fetch(data, :nonfoil), 1),
                      #oracle_text: elem(Map.fetch(data, :oracle_text), 1),
                      oversized: elem(Map.fetch(data, :oversized), 1),
                      #power: elem(Map.fetch(data, :power), 1),
                      reserved: elem(Map.fetch(data, :reserved), 1),
                      #toughness: elem(Map.fetch(data, :toughness), 1),
                      type_line: elem(Map.fetch(data, :type_line), 1),
                      #artist: elem(Map.fetch(data, :artist), 1),
                      booster: elem(Map.fetch(data, :booster), 1),
                      border_color: elem(Map.fetch(data, :border_color), 1),
                      card_back_id: elem(Map.fetch(data, :card_back_id), 1),
                      collector_number: elem(Map.fetch(data, :collector_number), 1),
                      digital: elem(Map.fetch(data, :digital), 1),
                      #flavor_text: elem(Map.fetch(data, :flavor_text), 1),
                      frame: elem(Map.fetch(data, :frame), 1),
                      full_art: elem(Map.fetch(data, :full_art), 1),
                      highres_image: elem(Map.fetch(data, :highres_image), 1),
                      #illustration_id: elem(Map.fetch(data, :illustration_id), 1),
                      #printed_name: elem(Map.fetch(data, :printed_name), 1),
                      #printed_text: elem(Map.fetch(data, :printed_text), 1),
                      #printed_type_line: elem(Map.fetch(data, :printed_type_line), 1),
                      promo: elem(Map.fetch(data, :promo), 1),
                      rarity: elem(Map.fetch(data, :rarity), 1),
                      released_at: elem(Map.fetch(data, :released_at), 1),
                      reprint: elem(Map.fetch(data, :reprint), 1),
                      scryfall_set_uri: elem(Map.fetch(data, :scryfall_set_uri), 1),
                      set_name: elem(Map.fetch(data, :set_name), 1),
                      set_search_uri: elem(Map.fetch(data, :set_search_uri), 1),
                      set_type: elem(Map.fetch(data, :set_type), 1),
                      set_uri: elem(Map.fetch(data, :set_uri), 1),
                      set: elem(Map.fetch(data, :set), 1),
                      story_spotlight: elem(Map.fetch(data, :story_spotlight), 1),
                      textless: elem(Map.fetch(data, :textless), 1),
                      variation: elem(Map.fetch(data, :variation), 1),
                      #variation_of: elem(Map.fetch(data, :variation_of), 1),
                      #watermark: elem(Map.fetch(data, :watermark), 1),
                      #previewed_at: elem(Map.fetch(data, :previewed_at), 1),
                      #source_uri: elem(Map.fetch(data, :source_uri), 1),
                      #source: elem(Map.fetch(data, :source), 1),
                      colors: colors,
                      color_identity: elem(Map.fetch(data, :color_identity), 1),
                      #color_indicator: elem(Map.fetch(data, :color_indicator), 1),
                      #REVISIT#legalities: "#{elem(Map.fetch(data, :legalities), 1)}",
                      #frame_effects: elem(Map.fetch(data, :frame_effects), 1),
                      games: elem(Map.fetch(data, :games), 1),
                      image_uris: image_uris
                      #REVISIT#prices: elem(Map.fetch(data, :prices), 1),
                      #promo_types: elem(Map.fetch(data, :promo_types), 1),
                      #REVISIT#purchase_uris: elem(Map.fetch(data, :purchase_uris), 1),
                      #REVISIT#related_uris: elem(Map.fetch(data, :related_uris), 1)
                      })
                    |> Deckcom.Repo.update()
              end
              #IO.puts inspect elem(Map.fetch(data, :image_uris), 1)
              
              more = elem(Map.fetch(parsed, :has_more), 1)
              IO.puts inspect more
              next = elem(Map.fetch(parsed, :next_page), 1)
              IO.puts inspect next
              if more === true do
                :timer.sleep(500)
                next_page_copy(next)
              end
            end
            #IO.puts inspect zn
          end
      end).() 
    end

    def next_page_copy(link) do
      IO.puts inspect :link
      #page = num + 1
      page = 1
      n = HTTPoison.request(
        "GET",
        "#{link}",
        "",
        [
          
          ],
        [       
          ]
            )
        |> case do
          {:ok, %{body: raw, status_code: code}} -> 
            {code, raw}
            {:error, %{reason: reason}} -> {:error, reason}
        end
        |> (fn {ok, body} ->
          IO.puts inspect body
          body
          |> Poison.decode(keys: :atoms)
          |> case do
            {:ok, parsed} -> 
            zn = Map.keys(parsed)
            if zn === [:error] do
              IO.puts inspect "Parse Error"
            else 
              data = Enum.at(elem(Map.fetch(parsed, :data), 1), 0)
              dataKeys = Map.keys(data)
              IO.puts inspect dataKeys
              name = elem(Map.fetch(data, :name), 1)
              IO.puts inspect name
              colors = []
              case Map.fetch(data, :colors) do
                :error ->
                  colors = []
                :ok ->
                  colors = elem(Map.fetch(data, :colors), 1)
                {:ok, _} ->
                  colors = elem(Map.fetch(data, :colors), 1)
              end
              image_uris = []
              case Map.fetch(data, :image_uris) do
                :error ->
                  image_uris = []
                :ok ->
                  image_uris = [elem(Map.fetch(elem(Map.fetch(data, :image_uris), 1), :normal), 1)]
                {:ok, _} ->
                  image_uris = [elem(Map.fetch(elem(Map.fetch(data, :image_uris), 1), :normal), 1)]
              end
              sid = elem(Map.fetch(data, :id), 1)
              #exists = Deckcom.Cards.get_card(scryfall_id: sid)
              #IO.puts inspect exists
              case Deckcom.Cards.get_card(scryfall_id: sid) do
                :ok ->
                  card = Deckcom.Cards.get_card(scryfall_id: sid)
                  Deckcom.Repo.get_by(Deckcom.Cards.Mtg, id: card.id)
                  |> Ecto.Changeset.change(%{
                    #arena_id: elem(Map.fetch(data, :arena_id), 1), 
                    scryfall_id: elem(Map.fetch(data, :id), 1),
                    language_code: elem(Map.fetch(data, :lang), 1),
                    #mgto_id: elem(Map.fetch(data, :mtgo_id), 1),
                    #mgto_foil_id: elem(Map.fetch(data, :mtgo_foil_id), 1),
                    #tcgplayer_id: elem(Map.fetch(data, :tcgplayer_id), 1),
                    object: elem(Map.fetch(data, :object), 1),
                    oracle_id: elem(Map.fetch(data, :oracle_id), 1),
                    prints_search_uri: elem(Map.fetch(data, :prints_search_uri), 1),
                    rulings_uri: elem(Map.fetch(data, :rulings_uri), 1),
                    scryfall_uri: elem(Map.fetch(data, :scryfall_uri), 1),
                    scryfall2_uri: elem(Map.fetch(data, :uri), 1),
                    cmc: "#{elem(Map.fetch(data, :cmc), 1)}",
                    #edhrec_rank: elem(Map.fetch(data, :edhrec_rank), 1),
                    foil: elem(Map.fetch(data, :foil), 1),
                    #hand_modifier: elem(Map.fetch(data, :hand_modifier), 1),
                    layout: elem(Map.fetch(data, :layout), 1),
                    #life_modifier: elem(Map.fetch(data, :life_modifier), 1),
                    #loyalty: elem(Map.fetch(data, :loyalty), 1),
                    #mana_cost: elem(Map.fetch(data, :mana_cost), 1),
                    name: name,
                    nonfoil: elem(Map.fetch(data, :nonfoil), 1),
                    #oracle_text: elem(Map.fetch(data, :oracle_text), 1),
                    oversized: elem(Map.fetch(data, :oversized), 1),
                    #power: elem(Map.fetch(data, :power), 1),
                    reserved: elem(Map.fetch(data, :reserved), 1),
                    #toughness: elem(Map.fetch(data, :toughness), 1),
                    type_line: elem(Map.fetch(data, :type_line), 1),
                    #artist: elem(Map.fetch(data, :artist), 1),
                    booster: elem(Map.fetch(data, :booster), 1),
                    border_color: elem(Map.fetch(data, :border_color), 1),
                    card_back_id: elem(Map.fetch(data, :card_back_id), 1),
                    collector_number: elem(Map.fetch(data, :collector_number), 1),
                    digital: elem(Map.fetch(data, :digital), 1),
                    #flavor_text: elem(Map.fetch(data, :flavor_text), 1),
                    frame: elem(Map.fetch(data, :frame), 1),
                    full_art: elem(Map.fetch(data, :full_art), 1),
                    highres_image: elem(Map.fetch(data, :highres_image), 1),
                    #illustration_id: elem(Map.fetch(data, :illustration_id), 1),
                    #printed_name: elem(Map.fetch(data, :printed_name), 1),
                    #printed_text: elem(Map.fetch(data, :printed_text), 1),
                    #printed_type_line: elem(Map.fetch(data, :printed_type_line), 1),
                    promo: elem(Map.fetch(data, :promo), 1),
                    rarity: elem(Map.fetch(data, :rarity), 1),
                    released_at: elem(Map.fetch(data, :released_at), 1),
                    reprint: elem(Map.fetch(data, :reprint), 1),
                    scryfall_set_uri: elem(Map.fetch(data, :scryfall_set_uri), 1),
                    set_name: elem(Map.fetch(data, :set_name), 1),
                    set_search_uri: elem(Map.fetch(data, :set_search_uri), 1),
                    set_type: elem(Map.fetch(data, :set_type), 1),
                    set_uri: elem(Map.fetch(data, :set_uri), 1),
                    set: elem(Map.fetch(data, :set), 1),
                    story_spotlight: elem(Map.fetch(data, :story_spotlight), 1),
                    textless: elem(Map.fetch(data, :textless), 1),
                    variation: elem(Map.fetch(data, :variation), 1),
                    #variation_of: elem(Map.fetch(data, :variation_of), 1),
                    #watermark: elem(Map.fetch(data, :watermark), 1),
                    #previewed_at: elem(Map.fetch(data, :previewed_at), 1),
                    #source_uri: elem(Map.fetch(data, :source_uri), 1),
                    #source: elem(Map.fetch(data, :source), 1),
                    colors: colors,
                    color_identity: elem(Map.fetch(data, :color_identity), 1),
                    #color_indicator: elem(Map.fetch(data, :color_indicator), 1),
                    #REVISIT#legalities: "#{elem(Map.fetch(data, :legalities), 1)}",
                    #frame_effects: elem(Map.fetch(data, :frame_effects), 1),
                    games: elem(Map.fetch(data, :games), 1),
                    image_uris: image_uris
                    #REVISIT#prices: elem(Map.fetch(data, :prices), 1),
                    #promo_types: elem(Map.fetch(data, :promo_types), 1),
                    #REVISIT#purchase_uris: elem(Map.fetch(data, :purchase_uris), 1),
                    #REVISIT#related_uris: elem(Map.fetch(data, :related_uris), 1)
                    })
                  |> Deckcom.Repo.update()
                  nil ->
                    case Deckcom.Cards.create_mtg(%{
                      #arena_id: elem(Map.fetch(data, :arena_id), 1), 
                      scryfall_id: elem(Map.fetch(data, :id), 1),
                      language_code: elem(Map.fetch(data, :lang), 1),
                      #mgto_id: elem(Map.fetch(data, :mtgo_id), 1),
                      #mgto_foil_id: elem(Map.fetch(data, :mtgo_foil_id), 1),
                      #tcgplayer_id: elem(Map.fetch(data, :tcgplayer_id), 1),
                      object: elem(Map.fetch(data, :object), 1),
                      oracle_id: elem(Map.fetch(data, :oracle_id), 1),
                      prints_search_uri: elem(Map.fetch(data, :prints_search_uri), 1),
                      rulings_uri: elem(Map.fetch(data, :rulings_uri), 1),
                      scryfall_uri: elem(Map.fetch(data, :scryfall_uri), 1),
                      scryfall2_uri: elem(Map.fetch(data, :uri), 1),
                      cmc: "#{elem(Map.fetch(data, :cmc), 1)}",
                      #edhrec_rank: elem(Map.fetch(data, :edhrec_rank), 1),
                      foil: elem(Map.fetch(data, :foil), 1),
                      #hand_modifier: elem(Map.fetch(data, :hand_modifier), 1),
                      layout: elem(Map.fetch(data, :layout), 1),
                      #life_modifier: elem(Map.fetch(data, :life_modifier), 1),
                      #loyalty: elem(Map.fetch(data, :loyalty), 1),
                      #mana_cost: elem(Map.fetch(data, :mana_cost), 1),
                      name: name,
                      nonfoil: elem(Map.fetch(data, :nonfoil), 1),
                      #oracle_text: elem(Map.fetch(data, :oracle_text), 1),
                      oversized: elem(Map.fetch(data, :oversized), 1),
                      #power: elem(Map.fetch(data, :power), 1),
                      reserved: elem(Map.fetch(data, :reserved), 1),
                      #toughness: elem(Map.fetch(data, :toughness), 1),
                      type_line: elem(Map.fetch(data, :type_line), 1),
                      #artist: elem(Map.fetch(data, :artist), 1),
                      booster: elem(Map.fetch(data, :booster), 1),
                      border_color: elem(Map.fetch(data, :border_color), 1),
                      card_back_id: elem(Map.fetch(data, :card_back_id), 1),
                      collector_number: elem(Map.fetch(data, :collector_number), 1),
                      digital: elem(Map.fetch(data, :digital), 1),
                      #flavor_text: elem(Map.fetch(data, :flavor_text), 1),
                      frame: elem(Map.fetch(data, :frame), 1),
                      full_art: elem(Map.fetch(data, :full_art), 1),
                      highres_image: elem(Map.fetch(data, :highres_image), 1),
                      #illustration_id: elem(Map.fetch(data, :illustration_id), 1),
                      #printed_name: elem(Map.fetch(data, :printed_name), 1),
                      #printed_text: elem(Map.fetch(data, :printed_text), 1),
                      #printed_type_line: elem(Map.fetch(data, :printed_type_line), 1),
                      promo: elem(Map.fetch(data, :promo), 1),
                      rarity: elem(Map.fetch(data, :rarity), 1),
                      released_at: elem(Map.fetch(data, :released_at), 1),
                      reprint: elem(Map.fetch(data, :reprint), 1),
                      scryfall_set_uri: elem(Map.fetch(data, :scryfall_set_uri), 1),
                      set_name: elem(Map.fetch(data, :set_name), 1),
                      set_search_uri: elem(Map.fetch(data, :set_search_uri), 1),
                      set_type: elem(Map.fetch(data, :set_type), 1),
                      set_uri: elem(Map.fetch(data, :set_uri), 1),
                      set: elem(Map.fetch(data, :set), 1),
                      story_spotlight: elem(Map.fetch(data, :story_spotlight), 1),
                      textless: elem(Map.fetch(data, :textless), 1),
                      variation: elem(Map.fetch(data, :variation), 1),
                      #variation_of: elem(Map.fetch(data, :variation_of), 1),
                      #watermark: elem(Map.fetch(data, :watermark), 1),
                      #previewed_at: elem(Map.fetch(data, :previewed_at), 1),
                      #source_uri: elem(Map.fetch(data, :source_uri), 1),
                      #source: elem(Map.fetch(data, :source), 1),
                      colors: colors,
                      color_identity: elem(Map.fetch(data, :color_identity), 1),
                      #color_indicator: elem(Map.fetch(data, :color_indicator), 1),
                      #REVISIT#legalities: "#{elem(Map.fetch(data, :legalities), 1)}",
                      #frame_effects: elem(Map.fetch(data, :frame_effects), 1),
                      games: elem(Map.fetch(data, :games), 1),
                      image_uris: image_uris
                      #REVISIT#prices: elem(Map.fetch(data, :prices), 1),
                      #promo_types: elem(Map.fetch(data, :promo_types), 1),
                      #REVISIT#purchase_uris: elem(Map.fetch(data, :purchase_uris), 1),
                      #REVISIT#related_uris: elem(Map.fetch(data, :related_uris), 1)
                    
                  }) do
                      {:ok, _} ->
                        "CARD COPIED"
                      {:error, _} ->
                        "CARD NOT COPIED"
                  end
                  _ ->
                    card = Deckcom.Cards.get_card(scryfall_id: sid)
                    Deckcom.Repo.get_by(Deckcom.Cards.Mtg, id: card.id)
                    |> Ecto.Changeset.change(%{
                      #arena_id: elem(Map.fetch(data, :arena_id), 1), 
                      scryfall_id: elem(Map.fetch(data, :id), 1),
                      language_code: elem(Map.fetch(data, :lang), 1),
                      #mgto_id: elem(Map.fetch(data, :mtgo_id), 1),
                      #mgto_foil_id: elem(Map.fetch(data, :mtgo_foil_id), 1),
                      #tcgplayer_id: elem(Map.fetch(data, :tcgplayer_id), 1),
                      object: elem(Map.fetch(data, :object), 1),
                      oracle_id: elem(Map.fetch(data, :oracle_id), 1),
                      prints_search_uri: elem(Map.fetch(data, :prints_search_uri), 1),
                      rulings_uri: elem(Map.fetch(data, :rulings_uri), 1),
                      scryfall_uri: elem(Map.fetch(data, :scryfall_uri), 1),
                      scryfall2_uri: elem(Map.fetch(data, :uri), 1),
                      cmc: "#{elem(Map.fetch(data, :cmc), 1)}",
                      #edhrec_rank: elem(Map.fetch(data, :edhrec_rank), 1),
                      foil: elem(Map.fetch(data, :foil), 1),
                      #hand_modifier: elem(Map.fetch(data, :hand_modifier), 1),
                      layout: elem(Map.fetch(data, :layout), 1),
                      #life_modifier: elem(Map.fetch(data, :life_modifier), 1),
                      #loyalty: elem(Map.fetch(data, :loyalty), 1),
                      #mana_cost: elem(Map.fetch(data, :mana_cost), 1),
                      name: name,
                      nonfoil: elem(Map.fetch(data, :nonfoil), 1),
                      #oracle_text: elem(Map.fetch(data, :oracle_text), 1),
                      oversized: elem(Map.fetch(data, :oversized), 1),
                      #power: elem(Map.fetch(data, :power), 1),
                      reserved: elem(Map.fetch(data, :reserved), 1),
                      #toughness: elem(Map.fetch(data, :toughness), 1),
                      type_line: elem(Map.fetch(data, :type_line), 1),
                      #artist: elem(Map.fetch(data, :artist), 1),
                      booster: elem(Map.fetch(data, :booster), 1),
                      border_color: elem(Map.fetch(data, :border_color), 1),
                      card_back_id: elem(Map.fetch(data, :card_back_id), 1),
                      collector_number: elem(Map.fetch(data, :collector_number), 1),
                      digital: elem(Map.fetch(data, :digital), 1),
                      #flavor_text: elem(Map.fetch(data, :flavor_text), 1),
                      frame: elem(Map.fetch(data, :frame), 1),
                      full_art: elem(Map.fetch(data, :full_art), 1),
                      highres_image: elem(Map.fetch(data, :highres_image), 1),
                      #illustration_id: elem(Map.fetch(data, :illustration_id), 1),
                      #printed_name: elem(Map.fetch(data, :printed_name), 1),
                      #printed_text: elem(Map.fetch(data, :printed_text), 1),
                      #printed_type_line: elem(Map.fetch(data, :printed_type_line), 1),
                      promo: elem(Map.fetch(data, :promo), 1),
                      rarity: elem(Map.fetch(data, :rarity), 1),
                      released_at: elem(Map.fetch(data, :released_at), 1),
                      reprint: elem(Map.fetch(data, :reprint), 1),
                      scryfall_set_uri: elem(Map.fetch(data, :scryfall_set_uri), 1),
                      set_name: elem(Map.fetch(data, :set_name), 1),
                      set_search_uri: elem(Map.fetch(data, :set_search_uri), 1),
                      set_type: elem(Map.fetch(data, :set_type), 1),
                      set_uri: elem(Map.fetch(data, :set_uri), 1),
                      set: elem(Map.fetch(data, :set), 1),
                      story_spotlight: elem(Map.fetch(data, :story_spotlight), 1),
                      textless: elem(Map.fetch(data, :textless), 1),
                      variation: elem(Map.fetch(data, :variation), 1),
                      #variation_of: elem(Map.fetch(data, :variation_of), 1),
                      #watermark: elem(Map.fetch(data, :watermark), 1),
                      #previewed_at: elem(Map.fetch(data, :previewed_at), 1),
                      #source_uri: elem(Map.fetch(data, :source_uri), 1),
                      #source: elem(Map.fetch(data, :source), 1),
                      colors: colors,
                      color_identity: elem(Map.fetch(data, :color_identity), 1),
                      #color_indicator: elem(Map.fetch(data, :color_indicator), 1),
                      #REVISIT#legalities: "#{elem(Map.fetch(data, :legalities), 1)}",
                      #frame_effects: elem(Map.fetch(data, :frame_effects), 1),
                      games: elem(Map.fetch(data, :games), 1),
                      image_uris: image_uris
                      #REVISIT#prices: elem(Map.fetch(data, :prices), 1),
                      #promo_types: elem(Map.fetch(data, :promo_types), 1),
                      #REVISIT#purchase_uris: elem(Map.fetch(data, :purchase_uris), 1),
                      #REVISIT#related_uris: elem(Map.fetch(data, :related_uris), 1)
                      })
                    |> Deckcom.Repo.update()
              end
              #IO.puts inspect elem(Map.fetch(data, :image_uris), 1)
              
              more = elem(Map.fetch(parsed, :has_more), 1)
              IO.puts inspect more
              next = elem(Map.fetch(parsed, :next_page), 1)
              IO.puts inspect next
              if more === true do
                :timer.sleep(500)
                next_page_copy(next)
              end
            end
            #IO.puts inspect zn
          end
      end).() 
    end
end
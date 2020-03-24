defmodule Deckcom.Face.Mtg do
  use Ecto.Schema
  import Ecto.Changeset

  schema "faces" do
    field :artist, :string
    field :flavor_text, :string
    field :illustration_id, :string
    field :loyalty, :string
    field :mana_cost, :string
    field :name, :string
    field :object, :string
    field :oracle_text, :string
    field :power, :string
    field :printed_name, :string
    field :printed_text, :string
    field :printed_type_line, :string
    field :toughness, :string
    field :type_line, :string
    field :watermark, :string
    field :color_indicator, {:array, :string}
    field :colors, {:array, :string}
    field :image_uris, {:array, :string}

    timestamps()
  end

  @doc false
  def changeset(mtg, attrs) do
    mtg
    |> cast(attrs, [:artist, :flavor_text, :illustration_id, :loyalty, :mana_cost, :name, :object, :oracle_text, :power, :printed_name, :printed_text, :printed_type_line, :toughness, :type_line, :watermark, :color_indicator, :colors, :image_uris])
    #Again, the take what you can give approach :)
    #|> validate_required([:artist, :flavor_text, :illustration_id, :loyalty, :mana_cost, :name, :object, :oracle_text, :power, :printed_name, :printed_text, :printed_type_line, :toughness, :type_line, :watermark])
  end
end

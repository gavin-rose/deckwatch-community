defmodule Deckcom.Related.Mtg do
  use Ecto.Schema
  import Ecto.Changeset

  schema "related" do
    field :component, :string
    field :name, :string
    field :object, :string
    field :scryfall_id, :string
    field :type_line, :string
    field :uri, :string

    timestamps()
  end

  @doc false
  def changeset(mtg, attrs) do
    mtg
    |> cast(attrs, [:scryfall_id, :object, :component, :name, :type_line, :uri])
    #Take what you can get approach, so if an error pops up while running database merges, we can easily avoid errors within our database
    #|> validate_required([:scryfall_id, :object, :component, :name, :type_line, :uri])
  end
end

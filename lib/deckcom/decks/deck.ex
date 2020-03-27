defmodule Deckcom.Decks.Deck do
  use Ecto.Schema
  import Ecto.Changeset

  schema "decks" do
    field :colors, {:array, :string}
    field :mainboard, {:array, :integer}
    field :maybeboard, {:array, :integer}
    field :owner, :integer
    field :play, {:array, :integer}
    field :sideboard, {:array, :integer}
    field :type, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(deck, attrs) do
    deck
    |> cast(attrs, [:owner, :mainboard, :sideboard, :maybeboard, :play, :colors, :type, :name])
    #|> validate_required([:owner, :mainboard, :sideboard, :maybeboard, :play, :colors, :type])
  end
end

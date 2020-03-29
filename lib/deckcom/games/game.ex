defmodule Deckcom.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :allowed_players, :integer
    field :attached_chat, :integer
    field :b_pool, {:array, :integer}
    field :c_pool, {:array, :integer}
    field :commander_damage, {:array, :integer}
    field :creator, :integer
    field :decks, {:array, :integer}
    field :g_pool, {:array, :integer}
    field :has_ended, :string
    field :infect, {:array, :integer}
    field :is_full, :boolean, default: false
    field :life, {:array, :integer}
    field :name, :string
    field :players, {:array, :integer}
    field :price_limit, :integer
    field :r_pool, {:array, :integer}
    field :stack, {:array, :integer}
    field :u_pool, {:array, :integer}
    field :w_pool, {:array, :integer}
    field :was_draw, :boolean, default: false
    field :winner, :integer

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:players, :creator, :is_full, :decks, :attached_chat, :name, :allowed_players, :price_limit, :life, :infect, :commander_damage, :stack, :w_pool, :u_pool, :b_pool, :r_pool, :g_pool, :c_pool, :has_ended, :winner, :was_draw])
    |> validate_required([:players, :creator, :is_full, :decks, :attached_chat, :name, :allowed_players, :price_limit, :life, :infect, :commander_damage, :stack, :w_pool, :u_pool, :b_pool, :r_pool, :g_pool, :c_pool, :has_ended, :winner, :was_draw])
  end
end

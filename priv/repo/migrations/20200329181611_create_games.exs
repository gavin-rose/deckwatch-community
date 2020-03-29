defmodule Deckcom.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :players, {:array, :integer}
      add :creator, :integer
      add :is_full, :boolean, default: false, null: false
      add :decks, {:array, :integer}
      add :attached_chat, :integer
      add :name, :string
      add :allowed_players, :integer
      add :price_limit, :integer
      add :life, {:array, :integer}
      add :infect, {:array, :integer}
      add :commander_damage, {:array, :integer}
      add :stack, {:array, :integer}
      add :w_pool, {:array, :integer}
      add :u_pool, {:array, :integer}
      add :b_pool, {:array, :integer}
      add :r_pool, {:array, :integer}
      add :g_pool, {:array, :integer}
      add :c_pool, {:array, :integer}
      add :has_ended, :string
      add :winner, :integer
      add :was_draw, :boolean, default: false, null: false

      timestamps()
    end

  end
end

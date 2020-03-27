defmodule Deckcom.Repo.Migrations.CreateDecks do
  use Ecto.Migration

  def change do
    create table(:decks) do
      add :owner, :integer
      add :mainboard, {:array, :integer}
      add :sideboard, {:array, :integer}
      add :maybeboard, {:array, :integer}
      add :play, {:array, :integer}
      add :colors, {:array, :string}
      add :type, :string
      add :name, :string

      timestamps()
    end

  end
end

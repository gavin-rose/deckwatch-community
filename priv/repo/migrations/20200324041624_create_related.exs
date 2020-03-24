defmodule Deckcom.Repo.Migrations.CreateRelated do
  use Ecto.Migration

  def change do
    create table(:related) do
      add :scryfall_id, :string
      add :object, :string
      add :component, :string
      add :name, :string
      add :type_line, :string
      add :uri, :string

      timestamps()
    end

  end
end

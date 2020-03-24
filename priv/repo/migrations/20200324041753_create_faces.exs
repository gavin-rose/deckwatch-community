defmodule Deckcom.Repo.Migrations.CreateFaces do
  use Ecto.Migration

  def change do
    create table(:faces) do
      add :artist, :string
      add :flavor_text, :string
      add :illustration_id, :string
      add :loyalty, :string
      add :mana_cost, :string
      add :name, :string
      add :object, :string
      add :oracle_text, :string
      add :power, :string
      add :printed_name, :string
      add :printed_text, :string
      add :printed_type_line, :string
      add :toughness, :string
      add :type_line, :string
      add :watermark, :string
      add :color_indicator, {:array, :string}
      add :colors, {:array, :string}
      add :image_uris, {:array, :string}

      timestamps()
    end

  end
end

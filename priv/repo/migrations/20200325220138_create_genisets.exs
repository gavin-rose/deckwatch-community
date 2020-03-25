defmodule Deckcom.Repo.Migrations.CreateGenisets do
  use Ecto.Migration

  def change do
    create table(:genisets) do
      add :ran_by, :integer
      add :repeating, :boolean, default: false, null: false
      add :repeating_schedule, :string
      add :geniset_method, :string

      timestamps()
    end

  end
end

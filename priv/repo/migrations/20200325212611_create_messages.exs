defmodule Deckcom.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :name, :string
      add :message, :string
      add :channel, :string
      add :private, :boolean, default: false, null: false
      add :uid, :integer

      timestamps()
    end

  end
end

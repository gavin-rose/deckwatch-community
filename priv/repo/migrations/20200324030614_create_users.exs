defmodule Deckcom.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name_full, :string, default: ""
      add :birthday, :date
      add :email, :string, default: ""
      add :bio, :string, default: ""
      add :notification_method, :string, default: "WEB"
      add :notification_key, :string, default: ""
      add :bio, :string, default: ""
      add :public_id, :string, default: ""
      add :friends, {:array, :integer}, default: []
      add :sent_requests, {:array, :integer}, default: []
      add :received_requests, {:array, :integer}, default: []
      add :past_games, {:array, :integer}, default: []
      add :groups, {:array, :integer}, default: []
      add :decks, {:array, :integer}, default: []
      add :unseen_notifications, {:array, :integer}, default: []

      timestamps()
    end

  end
end

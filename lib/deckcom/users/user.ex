defmodule Deckcom.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :bio, :string, default: ""
    field :birthday, :date
    field :email, :string, default: ""
    field :name_full, :string, default: ""
    field :notification_key, :string, default: ""
    field :notification_method, :string, default: "WEB"
    field :public_id, :string, default: ""
    field :friends, {:array, :integer}, default: []
    field :sent_requests, {:array, :integer}, default: []
    field :received_requests, {:array, :integer}, default: []
    field :past_games, {:array, :integer}, default: []
    field :groups, {:array, :integer}, default: []
    field :decks, {:array, :integer}, default: []
    field :unseen_notifications, {:array, :integer}, default: []

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name_full, :birthday, :email, :bio, :notification_method, :notification_key, :bio, :public_id, :friends, :sent_requests, :received_requests, :past_games, :groups, :decks, :unseen_notifications])
    |> validate_required([:name_full, :email])
  end
end

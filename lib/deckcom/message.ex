defmodule Deckcom.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :channel, :string
    field :content, :string
    field :name, :string
    field :private, :boolean, default: false
    field :uid, :integer

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:name, :content, :channel, :private, :uid])
    #|> validate_required([:name, :content, :channel, :private, :user_parent])
  end

  def get_messages(limit \\ 100) do
    Deckcom.Repo.all(Deckcom.Message, limit: limit)
  end
end

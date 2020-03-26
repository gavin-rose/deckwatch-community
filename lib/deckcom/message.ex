defmodule Deckcom.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :channel, :string
    field :message, :string
    field :name, :string
    field :private, :boolean, default: false
    field :uid, :integer
    field :cont_card, :string

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:name, :message, :channel, :private, :uid, :cont_card])
    #|> validate_required([:name, :content, :channel, :private, :user_parent])
  end

  def get_messages(limit \\ 100) do
    Deckcom.Repo.all(Deckcom.Message, limit: limit)
  end
end

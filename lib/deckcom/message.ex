defmodule Deckcom.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :channel, :string
    field :content, :string
    field :name, :string
    field :private, :boolean, default: false
    field :user_parent, :integer

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:name, :content, :channel, :private, :user_parent])
    |> validate_required([:name, :content, :channel, :private, :user_parent])
  end
end

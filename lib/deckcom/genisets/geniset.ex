defmodule Deckcom.Genisets.Geniset do
  use Ecto.Schema
  import Ecto.Changeset

  schema "genisets" do
    field :geniset_method, :string
    field :ran_by, :integer
    field :repeating, :boolean, default: false
    field :repeating_schedule, :string

    timestamps()
  end

  @doc false
  def changeset(geniset, attrs) do
    geniset
    |> cast(attrs, [:ran_by, :repeating, :repeating_schedule, :geniset_method])
    |> validate_required([:ran_by, :repeating, :repeating_schedule, :geniset_method])
  end
end

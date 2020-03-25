defmodule Deckcom.Genisets do
  @moduledoc """
  The Genisets context.
  """

  import Ecto.Query, warn: false
  alias Deckcom.Repo

  alias Deckcom.Genisets.Geniset

  @doc """
  Returns the list of genisets.

  ## Examples

      iex> list_genisets()
      [%Geniset{}, ...]

  """
  def list_genisets do
    Repo.all(Geniset)
  end

  @doc """
  Gets a single geniset.

  Raises `Ecto.NoResultsError` if the Geniset does not exist.

  ## Examples

      iex> get_geniset!(123)
      %Geniset{}

      iex> get_geniset!(456)
      ** (Ecto.NoResultsError)

  """
  def get_geniset!(id), do: Repo.get!(Geniset, id)

  @doc """
  Creates a geniset.

  ## Examples

      iex> create_geniset(%{field: value})
      {:ok, %Geniset{}}

      iex> create_geniset(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_geniset(attrs \\ %{}) do
    %Geniset{}
    |> Geniset.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a geniset.

  ## Examples

      iex> update_geniset(geniset, %{field: new_value})
      {:ok, %Geniset{}}

      iex> update_geniset(geniset, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_geniset(%Geniset{} = geniset, attrs) do
    geniset
    |> Geniset.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a geniset.

  ## Examples

      iex> delete_geniset(geniset)
      {:ok, %Geniset{}}

      iex> delete_geniset(geniset)
      {:error, %Ecto.Changeset{}}

  """
  def delete_geniset(%Geniset{} = geniset) do
    Repo.delete(geniset)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking geniset changes.

  ## Examples

      iex> change_geniset(geniset)
      %Ecto.Changeset{source: %Geniset{}}

  """
  def change_geniset(%Geniset{} = geniset) do
    Geniset.changeset(geniset, %{})
  end
end

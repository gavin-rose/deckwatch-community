defmodule Deckcom.Face do
  @moduledoc """
  The Face context.
  """

  import Ecto.Query, warn: false
  alias Deckcom.Repo

  alias Deckcom.Face.Mtg

  @doc """
  Returns the list of faces.

  ## Examples

      iex> list_faces()
      [%Mtg{}, ...]

  """
  def list_faces do
    Repo.all(Mtg)
  end

  @doc """
  Gets a single mtg.

  Raises `Ecto.NoResultsError` if the Mtg does not exist.

  ## Examples

      iex> get_mtg!(123)
      %Mtg{}

      iex> get_mtg!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mtg!(id), do: Repo.get!(Mtg, id)

  @doc """
  Creates a mtg.

  ## Examples

      iex> create_mtg(%{field: value})
      {:ok, %Mtg{}}

      iex> create_mtg(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mtg(attrs \\ %{}) do
    %Mtg{}
    |> Mtg.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mtg.

  ## Examples

      iex> update_mtg(mtg, %{field: new_value})
      {:ok, %Mtg{}}

      iex> update_mtg(mtg, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mtg(%Mtg{} = mtg, attrs) do
    mtg
    |> Mtg.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a mtg.

  ## Examples

      iex> delete_mtg(mtg)
      {:ok, %Mtg{}}

      iex> delete_mtg(mtg)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mtg(%Mtg{} = mtg) do
    Repo.delete(mtg)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mtg changes.

  ## Examples

      iex> change_mtg(mtg)
      %Ecto.Changeset{source: %Mtg{}}

  """
  def change_mtg(%Mtg{} = mtg) do
    Mtg.changeset(mtg, %{})
  end
end

defmodule DeckcomWeb.GenisetController do
  use DeckcomWeb, :controller

  alias Deckcom.Genisets
  alias Deckcom.Genisets.Geniset

  plug :secure
  defp secure(conn, _params) do
    user = get_session(conn, :current_user)
    case user do
    #can people get in without logging in? ask team
     nil ->
         conn 
         #|> assign(:current_user, nil) #
         |> redirect(to: "/auth/auth0") |> halt
     _ ->
       conn
       |> assign(:current_user, user)
    end
  end

  def index(conn, _params) do
    userCon = get_session(conn, :current_user)
    user = Deckcom.Users.get_user_by_email(email: userCon.email)
    case user.isAdmin do
      true ->
        genisets = Genisets.list_genisets()
        render(conn, "index.html", genisets: genisets)
      _ ->
        conn
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def new(conn, _params) do
    userCon = get_session(conn, :current_user)
    user = Deckcom.Users.get_user_by_email(email: userCon.email)
    case user.isAdmin do
      true ->
        changeset = Genisets.change_geniset(%Geniset{})
        render(conn, "new.html", changeset: changeset)
      _ ->
        conn
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def create(conn, %{"geniset" => geniset_params}) do
    userCon = get_session(conn, :current_user)
    user = Deckcom.Users.get_user_by_email(email: userCon.email)
    case user.isAdmin do
      true ->
        case Genisets.create_geniset(geniset_params) do
          {:ok, geniset} ->
            case Deckcom.Task.Geniset.manual("cards") do
              {:ok} ->
                conn
                |> put_flash(:info, "Geniset created successfully.")
                |> redirect(to: Routes.geniset_path(conn, :show, geniset))
              {:error} ->
                %Ecto.Changeset{} = changeset
                render(conn, "new.html", changeset: changeset)
            end
          {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, "new.html", changeset: changeset)
        end
      _ ->
        conn
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def show(conn, %{"id" => id}) do
    userCon = get_session(conn, :current_user)
    user = Deckcom.Users.get_user_by_email(email: userCon.email)
    case user.isAdmin do
      true ->
        geniset = Genisets.get_geniset!(id)
        render(conn, "show.html", geniset: geniset)
      false ->
        conn
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def edit(conn, %{"id" => id}) do
    userCon = get_session(conn, :current_user)
    user = Deckcom.Users.get_user_by_email(email: userCon.email)
    case user.isAdmin do
      true ->
        geniset = Genisets.get_geniset!(id)
        changeset = Genisets.change_geniset(geniset)
        render(conn, "edit.html", geniset: geniset, changeset: changeset)
      false ->
        conn
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def update(conn, %{"id" => id, "geniset" => geniset_params}) do
    userCon = get_session(conn, :current_user)
    user = Deckcom.Users.get_user_by_email(email: userCon.email)
    case user.isAdmin do
      true ->
        geniset = Genisets.get_geniset!(id)

        case Genisets.update_geniset(geniset, geniset_params) do
          {:ok, geniset} ->
            conn
            |> put_flash(:info, "Geniset updated successfully.")
            |> redirect(to: Routes.geniset_path(conn, :show, geniset))

          {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, "edit.html", geniset: geniset, changeset: changeset)
        end
      false ->
        conn
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def delete(conn, %{"id" => id}) do
    userCon = get_session(conn, :current_user)
    user = Deckcom.Users.get_user_by_email(email: userCon.email)
    case user.isAdmin do
      true ->
        geniset = Genisets.get_geniset!(id)
        {:ok, _geniset} = Genisets.delete_geniset(geniset)

        conn
        |> put_flash(:info, "Geniset deleted successfully.")
        |> redirect(to: Routes.geniset_path(conn, :index))
      false ->
        conn
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end
end

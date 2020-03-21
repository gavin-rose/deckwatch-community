defmodule Deckcom.Repo do
  use Ecto.Repo,
    otp_app: :deckcom,
    adapter: Ecto.Adapters.Postgres
end

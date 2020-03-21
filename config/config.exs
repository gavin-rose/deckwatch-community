# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :deckcom,
  ecto_repos: [Deckcom.Repo]

# Configures the endpoint
config :deckcom, DeckcomWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qAKBz05U1jQkIukv/A9Y10QnYAbXlu68XKFpRktj4pr5E8jpJRaj4y2sj/hH8VNB",
  render_errors: [view: DeckcomWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Deckcom.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :deckcom, DeckcomWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :deckcom, Deckcom.Repo,
  username: "postgres",
  password: "postgres",
  database: "deckcom_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

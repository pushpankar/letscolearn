use Mix.Config
config :letsColearn, LetsColearnWeb.Endpoint,
  load_from_system_env: true,
  url: [host: {:system, "HOST"}, port: {:system, "PORT"}],
  server: true,
  cache_static_manifest: "priv/static/cache_manifest.json",

config :letsColearn, LetsColearn.Repo,
    adapter: Ecto.Adapters.Postgres,
    url: System.get_env("DATABASE_URL"),
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
    ssl: false

# Do not print debug messages in production
config :logger, level: :info

config :guardian, Guardian,
  secret_key: System.get_env("GUARDIAN_SECRET_KEY")


# Finally import the config/prod.secret.exs
# which should be versioned separately.

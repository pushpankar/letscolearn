use Mix.Config
config :letsColearn, LetsColearnWeb.Endpoint,
  load_from_system_env: true,
  url: [host: {:system, "HOST"}, port: {:system, "PORT"}],
  server: true,
  version: Application.spec(:subs_web, :vsn),
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  session_cookie_name: System.get_env("SESSION_COOKIE_NAME"),
  session_cookie_signing_salt: System.get_env("SESSION_COOKIE_SIGNING_SALT"),
  session_cookie_encryption_salt: System.get_env("SESSION_COOKIE_ENCRYPTION_SALT")

# config :letsColearn, LetsColearn.Repo,
#   adapter: Ecto.Adapters.Postgres,
#   url: System.get_env("DATABASE_URL"),
#   pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
#   ssl: false

config :letsColearn, LetsColearn.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: System.get_env("RDS_DB_NAME"),
  username: System.get_env("RDS_USERNAME"),
  password: System.get_env("RDS_PASSWORD"),
  hostname: System.get_env("RDS_HOSTNAME"),
  port: System.get_env("RDS_PORT") || 5432,
  pool_size: 20,
  ssl: true

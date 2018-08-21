# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :letsColearn,
  ecto_repos: [LetsColearn.Repo]

# Configures the endpoint
config :letsColearn, LetsColearnWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WYxRZB5CrsHtCPsDOfLgkZlKPRva5NG2NUd1hyqssNrtA/7EBBDFFSrqtF/Ntd2+",
  render_errors: [view: LetsColearnWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LetsColearn.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

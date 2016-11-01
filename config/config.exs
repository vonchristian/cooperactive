# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :cooperactive,
  ecto_repos: [Cooperactive.Repo]

# Configures the endpoint
config :cooperactive, Cooperactive.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dxPlJYXDmyzu5Yuev3pXGGGkXMh/1FQ7GSYY4wodfRMMm1nrMDjPyQW9U5X6LOP/",
  render_errors: [view: Cooperactive.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Cooperactive.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

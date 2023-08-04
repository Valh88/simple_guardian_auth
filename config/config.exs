# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :simple_guardian_auth,
  ecto_repos: [SimpleGuardianAuth.Repo]

# Configures the endpoint
config :simple_guardian_auth, SimpleGuardianAuthWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: SimpleGuardianAuthWeb.ErrorHTML, json: SimpleGuardianAuthWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: SimpleGuardianAuth.PubSub,
  live_view: [signing_salt: "sAYG9d0F"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :simple_guardian_auth, SimpleGuardianAuth.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

# config :argon2_elixir,
#   t_cost: 8,
#   m_cost: 16,
#   parallelism: 2,
#   argron_type: 2

config :simple_guardian_auth, SimpleGuardianAuthWeb.Security.Guardian,
  issuer: "simple_guardian_auth",
  secret_key: "A2QhoBW5+qU4F79ac7Ozo4fUlRpzkeHOYORgJkCazWjvOH22e3esAjryekV/+5Qs"

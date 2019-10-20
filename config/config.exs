# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :projects_from_git,
  ecto_repos: [ProjectsFromGit.Repo]

# Configures the endpoint
config :projects_from_git, ProjectsFromGitWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oVU6AYROCjQ9Czm/PDPpnjvIEhvP++3sa/lX7fHR6edl4B/tptD0F4tW6pASPthX",
  render_errors: [view: ProjectsFromGitWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ProjectsFromGit.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

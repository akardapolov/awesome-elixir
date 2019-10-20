use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :projects_from_git, ProjectsFromGitWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :projects_from_git, ProjectsFromGit.Repo,
  username: "postgres",
  password: "postgres",
  database: "projects_from_git_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

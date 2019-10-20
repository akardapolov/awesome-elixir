defmodule ProjectsFromGit.Repo do
  use Ecto.Repo,
    otp_app: :projects_from_git,
    adapter: Ecto.Adapters.Postgres
end

defmodule ProjectsFromGit.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string
      add :desc, :string
      add :link, :string
      add :stars, :integer
      add :days, :integer
      add :group, :string

      timestamps()
    end

  end
end

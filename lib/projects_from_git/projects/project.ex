defmodule ProjectsFromGit.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :days, :integer
    field :desc, :string
    field :group, :string
    field :link, :string
    field :name, :string
    field :stars, :integer

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :desc, :link, :stars, :days, :group])
    |> validate_required([:name, :desc, :link, :stars, :days, :group])
  end
end

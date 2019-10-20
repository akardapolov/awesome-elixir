defmodule ProjectsFromGitWeb.PageController do
  use ProjectsFromGitWeb, :controller
  import Ecto.Query

def index(conn, params) do

  if params["min_stars"] != nil do
    param = String.to_integer(params["min_stars"]) - 1

    render conn, "index.html",

    groups: ProjectsFromGit.Repo.all(from a in ProjectsFromGit.Projects.Project,
    distinct: [asc: a.group],
    where: a.stars > ^param,
    order_by: [a.group]),

    projs0: ProjectsFromGit.Repo.all(from a in ProjectsFromGit.Projects.Project,
    order_by: [asc: :group, asc: :name],
    where: a.stars > ^param,
    select: %{:name => a.name, :desc => a.desc, :link => a.link, :stars => a.stars, :days => a.days, :group => a.group}),

    min_stars: param
  else
  render conn, "index.html",

    groups: ProjectsFromGit.Repo.all(from a in ProjectsFromGit.Projects.Project,
    distinct: [asc: a.group],
    order_by: [a.group]),

    projs0: ProjectsFromGit.Repo.all(from a in ProjectsFromGit.Projects.Project,
    order_by: [asc: :group, asc: :name],
    select: %{:name => a.name, :desc => a.desc, :link => a.link, :stars => a.stars, :days => a.days, :group => a.group}),

    min_stars: 0
  end

end

end
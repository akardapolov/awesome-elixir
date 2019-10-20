defmodule ProjectsFromGit.Loader do
  def load_to_db(file_in) do
    File.stream!(file_in)
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Stream.with_index()
    |> Enum.each(fn {contents, _line_num} ->
      changeset = ProjectsFromGit.Projects.Project.changeset(%ProjectsFromGit.Projects.Project{}, parse!(contents))
      ProjectsFromGit.Repo.insert(changeset)
    end)
  end

  def parse!(json) do
    try do
      Poison.Parser.parse!(json)
    rescue
      e in Poison.SyntaxError ->
        raise %{e | message: "#{e.message} (trying to parse \"#{json}\")"}
    end
  end

  def clear_all() do
    ProjectsFromGit.Repo.delete_all(ProjectsFromGit.Projects.Project)
  end
end

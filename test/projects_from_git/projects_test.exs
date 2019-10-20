defmodule ProjectsFromGit.ProjectsTest do
  use ProjectsFromGit.DataCase

  alias ProjectsFromGit.Projects

  describe "projects" do
    alias ProjectsFromGit.Projects.Project

    @valid_attrs %{days: 42, desc: "some desc", group: "some group", link: "some link", name: "some name", stars: 42}
    @update_attrs %{days: 43, desc: "some updated desc", group: "some updated group", link: "some updated link", name: "some updated name", stars: 43}
    @invalid_attrs %{days: nil, desc: nil, group: nil, link: nil, name: nil, stars: nil}

    def project_fixture(attrs \\ %{}) do
      {:ok, project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Projects.create_project()

      project
    end

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Projects.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Projects.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      assert {:ok, %Project{} = project} = Projects.create_project(@valid_attrs)
      assert project.days == 42
      assert project.desc == "some desc"
      assert project.group == "some group"
      assert project.link == "some link"
      assert project.name == "some name"
      assert project.stars == 42
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projects.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      assert {:ok, %Project{} = project} = Projects.update_project(project, @update_attrs)
      assert project.days == 43
      assert project.desc == "some updated desc"
      assert project.group == "some updated group"
      assert project.link == "some updated link"
      assert project.name == "some updated name"
      assert project.stars == 43
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Projects.update_project(project, @invalid_attrs)
      assert project == Projects.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Projects.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Projects.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Projects.change_project(project)
    end
  end
end

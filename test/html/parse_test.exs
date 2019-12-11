
defmodule ProjectsFromGit.ParseTest do
    use ExUnit.Case, async: true
    Application.ensure_all_started(:hackney)
    doctest ProjectsFromGit.Parser
    
    # html
    @html_in_full File.read!("test/html/awesome_elixir.html")
    @html_links_in_links File.read!("test/html/awesome_elixir_links.html")

    # github stars
    stars_in = "https://github.com/talklittle/ffmpex"
    stars_out = "https://api.github.com/repos/talklittle/ffmpex"
    @json_for_stars File.read!("test/html/ffmpex.json")

    # templates
    @html_groups_template File.read!("test/html/template/groups.file")
    @html_links_template File.read!("test/html/template/links.file")
    @html_namedesc_template File.read!("test/html/template/out.file")

    # output
    groups_out0 = ("test/html/out/groups.file")
    groups_out1 = ("test/html/out/groups.file")
    links_out0 = ("test/html/out/links.file")
    links_out1 = ("test/html/out/links.file")
    
    # result
    all_out = ("test/html/out/out.file")

    # Parse groups links and name|desc
    
    ProjectsFromGit.Parser.parseGroups(@html_links_in_links, groups_out0)
    ProjectsFromGit.Parser.parseLinks(@html_links_in_links, links_out0)

    ProjectsFromGit.Parser.parse(groups_out1, links_out1, all_out)
    assert @html_namedesc_template == File.read!(all_out)

    # Test parsing github link: html -> api
    assert ProjectsFromGit.Parser.html_to_api_github(stars_in) == stars_out
    # Test parsing stars
    # %HTTPoison.Response{body: body} = HTTPoison.get!(url_api)
    stars = ProjectsFromGit.Parser.parseStarsSubs(@json_for_stars)
    assert stars.stars == 95
    
    # Load to database
    Ecto.Adapters.SQL.Sandbox.checkout(ProjectsFromGit.Repo)
    ProjectsFromGit.Loader.clear_all
    ProjectsFromGit.Loader.load_to_db(all_out)

  end

  
defmodule ProjectsFromGit.Composer do
  def start() do
    IO.puts("Loading data in progress...")
    Application.ensure_all_started(:hackney)

    url = 'https://github.com/h4cc/awesome-elixir'
    html_in = "test/production/awesome_elixir_links.html"
    all_out = "test/production/out.file"

    # output
    groups_out0 = "test/production/groups.file"
    groups_out1 = "test/production/groups.file"
    links_out0 = "test/production/links.file"
    links_out1 = "test/production/links.file"

    # get html data from github
    %HTTPoison.Response{body: body} = HTTPoison.get!(url)
    File.write!(html_in, body)

    # parse html
    ProjectsFromGit.Parser.parseGroups(File.read!(html_in), groups_out0)
    ProjectsFromGit.Parser.parseLinks(File.read!(html_in), links_out0)
    ProjectsFromGit.Parser.parse(groups_out1, links_out1, all_out)

    # clear and load fresh data to database
    ProjectsFromGit.Loader.clear_all()
    ProjectsFromGit.Loader.load_to_db(all_out)
  end
end

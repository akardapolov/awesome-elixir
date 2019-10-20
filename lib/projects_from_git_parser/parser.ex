defmodule ProjectsFromGit.Parser do
  def parseGroups(body, file_res) do
    {:ok, file} = File.open(file_res, [:write, :utf8])

    # Groups
    body
    |> Floki.find("h2")
    |> Enum.map(fn v ->
      v
      |> Floki.text()
      |> (&IO.write(file, &1 <> "\n")).()
    end)

    File.close(file)
  end

  def parseLinks(body, file_res) do
    {:ok, filel} = File.open(file_res, [:write, :utf8])

    # All
    body
    |> Floki.find("article")
    |> Floki.find("h2 ~ ul")
    |> Enum.map(fn v ->
      v
      |> Floki.find("li")
      |> Enum.map(fn li ->
        li
        |> Floki.find("a")
        |> Enum.with_index()
        |> Enum.max_by(fn {li, index} ->
          if index == 0 do
            # IO.puts("#{index}")
            # name
            li
            |> Floki.text()
            |> (&IO.write(filel, &1 <> "###")).()

            # links
            li
            |> Floki.attr("a", "href", fn href ->
              if href != nil do
                IO.write(filel, href <> "###")
              end
            end)
          end
        end)

        # description
        li
        |> Floki.find("li")
        |> Floki.text()
        |> String.split(" - ")
        |> Enum.with_index()
        |> Enum.max_by(fn {li, index} ->
          if index == 1 do
            IO.write(filel, li <> "____")
          end
        end)
      end)

      IO.write(filel, "\n")
    end)

    File.close(filel)
  end

  def parse(dest, destl, dest_out) do
    # dest = "groups.file"
    {:ok, file} = File.open(dest, [:read, :utf8])

    # destl = "links.file"
    {:ok, filel} = File.open(destl, [:read, :utf8])

    # csv
    {:ok, filecsv} = File.open(dest_out, [:write, :utf8])

    File.stream!(dest)
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Stream.with_index()
    |> Enum.each(fn {contents, line_num} ->
      # parse
      File.stream!(destl)
      |> Stream.map(&String.replace(&1, "\n", ""))
      |> Stream.with_index()
      |> Enum.each(fn {contents1, line_num1} ->
        if line_num1 == line_num do
          String.split(contents1, "____", trim: true)
          |> Enum.filter(&(&1 != []))
          |> Enum.filter(&(&1 != nil))
          |> Enum.filter(&(&1 != [""]))
          |> Enum.each(fn x ->

            sp = String.split(x, "###", trim: true)

            # load Stars
            #url_api = html_to_api_github(Enum.at(sp, 1))
            #%HTTPoison.Response{body: body} = HTTPoison.get!(url_api)
            # Process.sleep 1_000
            #IO.puts(Enum.at(sp, 1))
            #stars = ProjectsFromGit.Parser.parseStarsSubs(body)

            {_status, result} =
              JSON.encode(
                name: Enum.at(sp, 0),
                desc: Enum.at(sp, 2),
                link: Enum.at(sp, 1),
                stars: String.length(Enum.at(sp, 2)), #0, #stars.stars,
                days: 0,
                group: contents
              )

            IO.write(filecsv, result)
            IO.write(filecsv, "\n")
          end)
        end
      end)
    end)

    File.close(file)
    File.close(filel)

    File.close(filecsv)
  end

  defmodule StarsSubs do
    defstruct [:stars, :subs]
  end

  def parseStarsSubs(body) do
    try do
      json = Poison.decode!(body)

      %StarsSubs{
        stars: json["stargazers_count"],
        subs: json["stargazers_count"]
      }
    rescue
      _ ->
        %StarsSubs{
          stars: 0,
          subs: 0
        }
    end
  end

  def html_to_api_github(url) do
    String.replace(url, "github.com", "api.github.com/repos")
  end
end

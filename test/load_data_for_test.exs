defmodule ProjectsFromGit.LoadDataForTest do
    use HTTPoison.Base, ExUnit.Case
  
    Application.ensure_all_started(:hackney)
    
    #IO.puts "load data for testing purposes"
    #url = 'https://github.com/h4cc/awesome-elixir'
    
    #%HTTPoison.Response{body: body} = HTTPoison.get!(url)
    #File.write!("test/html/awesome_elixir.html", body)

  end
  
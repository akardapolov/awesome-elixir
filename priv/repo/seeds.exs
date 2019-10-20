# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ProjectsFromGit.Repo.insert!(%ProjectsFromGit.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

IO.puts("Loading seed data in progress...")

Application.ensure_all_started(:hackney)

all_out = "test/production/out_example.file"
ProjectsFromGit.Loader.load_to_db(all_out)
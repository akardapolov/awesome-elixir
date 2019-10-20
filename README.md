# Awesome Elixir

Elixir is awesome. And it has a vast awesome [h4cc/awesome-elixir](https://github.com/h4cc/awesome-elixir). This is a mirror of it where each library is marked with number of stars at [Github](https://github.com/).

## Table of contents
- [Install](#install)
- [Run](#run)
- [Clean up database](#clean-up-database)
- [Bugs and feature requests](#bugs-and-feature-requests)
- [License](#license)
- [Learn more](#learn-more)

## Install
Install Phoenix and Postgres database on Windows using [chocolatey](https://chocolatey.org/)
  * Run as Administrator the following: `@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin`
  - Install Elixir: `choco install elixir -version 1.9.1 -y`
  - Install Hex: `mix local.hex`
  - Install phoenix: `mix archive.install hex phx_new 1.4.10`
  - Install Nodejs: `choco install nodejs.install -y` and brunch `npm install -g brunch`
  - Install postgres database`choco install postgresql`
  - Set default password for postgres database: postgres (`ALTER USER Postgres WITH PASSWORD 'postgres'`)

## Run  
Open cmd session, go to the root of project directory and do the following:
  - Install dependencies with `mix deps.get`
  - Create, migrate and populate your database with `mix ecto.setup` (see database connection property in config/dev.exs and config/test.exs, priv/repo/seeds.exs)
  - Install Node.js dependencies with `npm install`
  - Run tests `mix test`
  - Start Phoenix endpoint with `mix phx.server`
  
Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Clean up database
Clean up development and test databases
  - Run `mix ecto.drop`
  - Run in postgres database `drop database projects_from_git_test`;

## Bugs and feature requests
List a bug and feature request: [Issues](https://github.com/akardapolov/awesome-elixir/issues)  

## License
[![GPLv3 license](https://img.shields.io/badge/License-GPLv3-blue.svg)](http://perso.crans.org/besson/LICENSE.html)

  Code released under the GNU General Public License v3.0  
  
## Learn more
  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
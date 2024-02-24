import Config

config :smart_market, ecto_repos: [SmartMarket.Repo]

import_config("#{Mix.env()}.exs")

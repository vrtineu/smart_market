import Config

config :smart_market, ecto_repos: [SmartMarket.Repo]
config :smart_market, SmartMarket.Repo, migration_primary_key: [type: :uuid]

import_config("#{Mix.env()}.exs")

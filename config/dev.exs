import Config

config :smart_market, SmartMarket.Repo,
  username: "postgres",
  password: "postgres",
  database: "smart_market_dev",
  hostname: "localhost",
  pool_size: 10

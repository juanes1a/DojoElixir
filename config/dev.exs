import Config

config :dojo_elixir,
       http_port: 8083,
       enable_server: true,
       secret_name: "DojoElixir",
       region: "us-east-1",
       token_exp: 3600,
       version: "1.2.3",
       user_repo: DojoElixir.Adapters.Repositories.Users.UserGateway

config :ex_aws,
       region: "us-east-1",
       access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, {:awscli, "default", 30}, :instance_role],
       secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, {:awscli, "default", 30}, :instance_role]

config :logger,
       level: :debug

config :dojo_elixir,
       DojoElixir.Adapters.Repositories.Repo,
       #loggers: [DojoElixir.Helpers.Metrics.RepoInstrumenter, Ecto.LogEntry],
       database: "postgres",
       username: "todo_admin",
       password: "!QAZxsw2#EDC",
       hostname: "tododatabase.cluster-czjpirjqvlyp.us-east-1.rds.amazonaws.com",
       show_sensitive_data_on_connection_error: true,
       pool_size: 10


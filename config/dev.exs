import Config

config :dojo_elixir,
       http_port: 8083,
       enable_server: true,
       secret_name: "DojoElixir",
       region: "us-east-1",
       token_exp: 3600,
       version: "1.2.3"

config :ex_aws,
       region: "us-east-1",
       access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, {:awscli, "default", 30}, :instance_role],
       secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, {:awscli, "default", 30}, :instance_role]

config :logger,
       level: :debug

config :dojo_elixir,
       DojoElixir.Adapters.Repositories.Repo,
       database: "",
       username: "",
       password: "",
       hostname: "",
       show_sensitive_data_on_connection_error: true,
       pool_size: 10

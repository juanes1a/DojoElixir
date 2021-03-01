defmodule DojoElixir.Application do
  alias DojoElixir.Config.AppConfig
  alias DojoElixir.EntryPoint.User.UserController
  alias DojoElixir.Adapters.Secrets.SecretManagerAdapter
  alias DojoElixir.Adapters.Repositories.Repo
  alias DojoElixir.Config.{AppConfig, ConfigHolder}

  use Application
  require Logger

  def start(_type,  _args) do
    config = AppConfig.load_config()
    in_test? = Application.fetch_env(:dojo_elixir, :in_test)

    children = with_plug_server(config) ++ application_children(in_test?)

    opts = [strategy: :one_for_one, name: DojoElixir.Supervisor]
    Supervisor.start_link(children, opts)

  end

  defp with_plug_server(%AppConfig{enable_server: true, http_port: port}) do
    Logger.info("Configure Http server in port #{inspect(port)}}")
    [
      {
        Plug.Cowboy,
        scheme: :http,
        plug: UserController,
        options: [
          port: port
        ]
      }
    ]
  end

  defp with_plug_server(%AppConfig{enable_server: false}), do: []

  def application_children({:ok, true} = _test_env) do
    [
      {ConfigHolder, AppConfig.load_config()}
    ]
  end

  def application_children(_other_env) do
    [
      {ConfigHolder, AppConfig.load_config()},
      #{SecretManagerAdapter, []},
      {Repo, []},
    ]
  end

end

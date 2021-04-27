defmodule DojoElixir.Config.AppConfig do
  defstruct [
    :http_port,
    :enable_server,
    :secret_name,
    :region,
    :token_exp,
    :version,
    :user_repo
  ]

  def load_config do
    %__MODULE__{
      http_port: load(:http_port),
      enable_server: load(:enable_server),
      secret_name: load(:secret_name),
      region: load(:region),
      token_exp: load(:token_exp),
      version: load(:version),
      user_repo: load(:user_repo)
    }
  end

  defp load(property_name), do: Application.fetch_env!(:dojo_elixir, property_name)
end

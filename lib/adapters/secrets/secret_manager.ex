defmodule DojoElixir.Adapters.Secrets.SecretManagerAdapter do
  use GenServer
  alias DojoElixir.Config.ConfigHolder
  alias DojoElixir.Utils.DataTypeUtils
  @compile if Mix.env == :test, do: :export_all

  def start_link(async_init) do
    GenServer.start_link(__MODULE__, async_init, name: __MODULE__)
  end

  def init(true = _async_init) do
    create_ets()
    send(self(), :get_secret)
    {:ok, nil}
  end

  def init(_async_init) do
    create_ets()
    {:ok, get_initial_secret()}
  end

  defp create_ets do
    :ets.new(:secret_manager_adapter, [:named_table, read_concurrency: true])
  end

  def handle_info(:get_secret, _args) do
    {:noreply, get_initial_secret()}
  end

  defp get_initial_secret() do
    secret_name = ConfigHolder.conf.secret_name
    region = ConfigHolder.conf.region
    secret = get_secret_value(secret_name, region)
             |> Poison.decode!
             |> DataTypeUtils.normalize

    original = secret[:JWS_PRIKEY];
    private_key = "-----BEGIN RSA PRIVATE KEY-----\n" <> original <> "\n-----END RSA PRIVATE KEY-----";
    secret = secret
             |> Map.put(:JWS_PRIKEY, private_key)
             |> Map.put_new(:jws_secret, original)

    :ets.insert(:secret_manager_adapter, {:secret, secret})
    secret
  end

  def get_secret() do
    case :ets.lookup(:secret_manager_adapter, :secret) do
      [{_, secret}] -> secret
      _ -> GenServer.call(__MODULE__, :get_secret)
    end
  end

  def handle_call(:get_secret, _from, state) do
    {:reply, state, state}
  end

  defp get_secret_value(secret_name, region) do
    ExAws.SecretsManager.get_secret_value(secret_name)
    |> ExAws.request(region: region)
    |> case do
         {:ok, %{"SecretString" => secret_string}} -> secret_string
         {code, rs} -> {code, rs}
         no_expected -> {:error, no_expected}
       end
  end

end

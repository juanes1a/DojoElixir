defmodule DojoElixir.Adapters.Repositories.Repo do
  alias DojoElixir.Adapters.Secrets.SecretManagerAdapter
  alias Ecto.Adapters.SQL
  alias DBConnection.ConnectionError
  import Ecto.Queryable
  use Ecto.Repo,
    otp_app: :dojo_elixir,
    adapter: Ecto.Adapters.Postgres

  def health() do
    try do
      case SQL.query(__MODULE__, "select 1", []) do
        {:ok, _res} -> {:ok, :up}
        _error -> :error
      end
    rescue
      ConnectionError -> :error
    end
  end
end

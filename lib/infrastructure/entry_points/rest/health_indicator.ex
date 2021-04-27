defmodule DojoElixir.EntryPoint.HealthIndicator do
  require Logger
  alias DojoElixir.Adapters.Repositories.Repo

  def health() do
    case Repo.health() do
      {:ok, _} -> Poison.encode!(%{status: "UP"})
      error -> Logger.error "Health check error: #{inspect(error)}"
               %{status: 503, body: Poison.encode!(%{status: "DOWN"})}
    end
  end

end

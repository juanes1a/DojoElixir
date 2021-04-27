defmodule DojoElixir.Adapters.Repositories.Users.UserGateway do

  @behaviour DojoElixir.Core.Users.UserBehaviour

  alias DojoElixir.Adapters.Repositories.Repo
  alias DojoElixir.Adapters.Repositories.Users.User

  import Ecto.Query, warn: false

  def list_all_users do
    User
    |> Repo.all()
    |> extract()
  end

  defp extract(result) when is_list(result), do: {:ok, result}

  defp extract(result) do
    case result do
      %User{} = user -> {:ok, user}
      {:ok, %User{}=user} -> {:ok, user}
      nil -> {:error, :not_found}
      other -> {:error, other}
    end
  end


end

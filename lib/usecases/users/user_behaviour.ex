defmodule DojoElixir.Core.Users.UserBehaviour do
  @callback list_all_users() :: {:ok, users_list :: list} | {:error, reason :: term}
end

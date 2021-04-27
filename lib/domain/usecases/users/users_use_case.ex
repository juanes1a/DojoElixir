defmodule DojoElixir.UseCase.Users.UsersUseCase do
  require Logger

  @user_repo_adapter Application.fetch_env!(:dojo_elixir, :user_repo)

  def get_all_users do
    with {:ok, user_list} = @user_repo_adapter.list_all_users() do
      user_list
    else
      {:error, :not_foud} -> Logger.error("Data not found")
      {:error, reason} -> Logger.error(reason)
    end
  end


end

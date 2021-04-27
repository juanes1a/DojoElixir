defmodule DojoElixir.EntryPoint.User.UserController do
  alias DojoElixir.EntryPoint.HealthIndicator
  alias DojoElixir.UseCase.Users.UsersUseCase

  require Logger

  use Plug.Router

  plug CORSPlug, methods: ["GET", "POST"]
  plug Plug.Logger, log: :debug
  plug DojoElixir.Helpers.Metrics.PlugInstrumenter
  plug :match
  plug Plug.Parsers, parsers: [:urlencoded, :json], json_decoder: Poison
  plug :dispatch

  get "/health" do
    HealthIndicator.health()
    |> build_response(conn)
  end

  get "/api/users/" do
    UsersUseCase.get_all_users()
    |> build_response(conn)
  end

  def build_empty_response(_, conn) do
    build_response(%{status: 204, body: ""}, conn)
  end

  def build_response(%{cookie: {key, value}}, conn) do
    conn
    |> put_resp_cookie(key, value, path: "/", http_only: true, secure: true, same_site: "Strict")
    |> send_resp(200, "")
  end

  def build_response(%{status: status, body: body}, conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, body)
  end

  def build_response(response, conn) do
    build_response(%{status: 200, body: Poison.encode!(response)}, conn)
  end

  match _ do
    conn
    |> handle_not_found(Logger.level())
  end

  defp handle_not_found(conn, :debug) do
    %{request_path: path} = conn
    body = Poison.encode!(%{status: 404, path: path})
    send_resp(conn, 404, body)
  end
  defp handle_not_found(conn, _level) do
    send_resp(conn, 404, "")
  end
end

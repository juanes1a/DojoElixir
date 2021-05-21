defmodule DojoElixir.EntryPoint.User.UserController do
  alias DojoElixir.EntryPoint.HealthIndicator
  alias DojoElixir.UseCase.Users.UsersUseCase
  import DojoElixir.Utils.Telemetry
  require Logger

  use Plug.Router

  plug CORSPlug, methods: ["GET", "POST"]
  plug Plug.Logger, log: :debug
  plug :match
  plug Plug.Parsers, parsers: [:urlencoded, :json], json_decoder: Poison
  plug :dispatch
  plug Plug.Telemetry, event_prefix: [:dojo_elixir, :plug]


  get "/health" do
    start_ms = System.monotonic_time(:milliseconds)
    HealthIndicator.health()
    |> build_response(conn, start_ms)
  end

  get "/api/users/" do
    start_ms = System.monotonic_time(:millisecond)
    #telemetry_measurement(:http, 'count', 1, %{controller: "users", operation: 'get_users'})
    UsersUseCase.get_all_users()
    |> build_response(conn, start_ms)
  end

  def build_empty_response(_, conn, start_time) do
    build_response(%{status: 204, body: ""}, conn, start_time)
  end

  def build_response(%{status: status, body: body}, conn, start_time) do
    end_ms = System.monotonic_time(:millisecond)
    diff = end_ms - start_time
    #telemetry_measurement(:http, 'stop', diff)
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, body)
  end

  def build_response(response, conn, start_time) do
    build_response(%{status: 200, body: Poison.encode!(response)}, conn, start_time)
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

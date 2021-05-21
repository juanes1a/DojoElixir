defmodule DojoElixir.Utils.Telemetry do
  import Telemetry.Metrics

  def telemetry_measurement(object, operation, value, tags) do
    :telemetry.execute([:dojo_elixir, object], %{"#{operation}": value}, tags)
  end

  def telemetry_measurement(object, operation, value) do
    :telemetry.execute([:dojo_elixir, object], %{"#{operation}": value}, %{})
  end
end

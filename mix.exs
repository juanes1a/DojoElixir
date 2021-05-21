defmodule DojoElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :dojo_elixir,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :dev,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {DojoElixir.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.4"},
      {:postgrex, "~> 0.15.0"},
      {:uuid, "~> 1.1"},
      {:ex_aws, "~> 2.0"},
      {:ex_aws_secretsmanager, "~> 2.0"},
      {:hackney, "~> 1.9"},
      {:configparser_ex, "~> 4.0"},
      {:plug_cowboy, "~> 2.2"},
      {:cors_plug, "~> 2.0"},
      {:poison, "~> 4.0"},
      {:jason, "~> 1.2"},
      {:joken, "~> 2.2"},
      {:distillery, "~> 2.1"},
      {:castore, ">= 0.0.0"},
      {:murmur, "~> 1.0"},
      {:junit_formatter, "~> 3.1", only: [:test]},
      {:mock, "~> 0.3.0", only: :test},
      {:fnv1a, "~> 0.1.0", only: :dev},
      {:fnv, "~> 0.3.2", only: :dev},
      {:benchee, "~> 1.0", only: :dev},
      {:benchee_html, "~> 1.0", only: :dev},
      {:telemetry_metrics_prometheus, "~> 1.0"},
      {:telemetry_poller, "~> 0.5.1"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end

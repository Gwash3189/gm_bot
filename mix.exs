defmodule GmBot.Mixfile do
  use Mix.Project

  def project do
    [app: :gm_bot,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :crypto, :ssl, :postgrex, :ecto, :httpoison],
     mod: mod]
  end

  defp mod do
    if Mix.env == :test do
      []
    else
      {GmBot, []}
    end
  end

  defp deps do
    [
      {:simpler_slack, "~> 0.0.6"},
      {:postgrex, ">= 0.0.0"},
      {:ecto, "~> 2.0.0"},
      {:poison, "~> 2.0"},
      {:logger_file_backend, "~> 0.0.9"}
    ]
  end
end

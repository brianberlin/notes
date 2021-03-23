defmodule Notes.MixFile do
  use Mix.Project

  @app :notes

  def project do
    [
      app: :notes,
      version: "0.0.1",
      deps: deps(),
      releases: [{@app, release()}],
      preferred_cli_env: [release: :prod]
    ]
  end

  def application do
    [
      mod: {Notes, []}
    ]
  end

  defp deps do
    [
      {:bakeware, github: "bake-bake-bake/bakeware", runtime: false}
    ]
  end

  defp release do
    [
      overwrite: true,
      cookie: "#{@app}_cookie",
      quiet: true,
      compression_level: 1,
      steps: [:assemble, &Bakeware.assemble/1],
      strip_beams: Mix.env() == :prod
    ]
  end
end

defmodule Notes.MixFile do
  use Mix.Project
  def project do
    [
      app: :notes,
      version: "0.0.1",
      escript: escript(),
    ]
  end

  # add the entry point
  defp escript do
    [main_module: Notes]
  end

end

defmodule Jazz.Mixfile do
  use Mix.Project

  def project do
    [ app: :jazz,
      version: "0.2.2",
      deps: deps(),
      package: package(),
      description: "JSON handling library for Elixir.",
      consolidate_protocols: Mix.env != :test ]
  end

  defp package do
    [ maintainers: ["meh"],
      licenses: ["WTFPL"],
      links: %{"GitHub" => "https://github.com/meh/jazz"} ]
  end

  defp deps do
    [ { :ex_doc, "~> 0.15", only: [:dev] } ]
  end

end

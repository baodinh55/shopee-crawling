defmodule Spider do
  use Crawly.Spider

  @impl Crawly.Spider
  def base_url(), do: "https://shopee.vn/apple_flagship_store"

  @impl Crawly.Spider
  def init() do
    [
      start_urls: [
        "https://shopee.vn/apple_flagship_store"
      ]
    ]
  end

  @impl Crawly.Spider
  def parse_item(response) do
    # Parse response body to document
    #response = Crawly.fetch("https://shopee.vn/apple_flagship_store")
    {:ok, document} = Floki.parse_document(response.body)
    inven_1 = document |> Floki.find(".shop-collection-view")
    inven_2 = document |> Floki.find(".shop-all-product-view")
    inven_3 = document |> Floki.find(".shop-sold-out-items-view")
    inven = inven_1++inven_2++inven_3
    #inven = document |> Floki.find(".shop-sold-out-items-view")
    #IO.inspect(inven)
    name = Floki.find(inven, "._1NoI8_")
    price_1 = Floki.find(inven, ".djJP_7")
    price_2 = Floki.find(inven, "._1xk7ak")
    price = price_1++price_2
    list_name = name
      |> Enum.map(fn x -> elem(x,2) end)
      |> List.flatten
    list_price = price
      |> Enum.map(fn x -> elem(x,2) end)
      |> List.flatten
    jsons = for {x,y} <- Enum.zip(list_name,list_price), do: %{Name: x, Price: y}
    IO.inspect(jsons)
    #File.write("test.txt", jsons)
    #x = Poison.decode(jsons)
    #IO.inspect(x)
    File.write("test.json", Poison.encode!(jsons))
    %Crawly.ParsedItem{:items => [jsons],:requests => []}

  end

  #defp build_absolute_url(url), do: URI.merge(base_url(), url) |> to_string()
end

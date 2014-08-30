defmodule ParserBench do
  use Benchfella

  # We wont test Jazz, since it's parser is simply an earlier version of
  # Poison's parser.

  bench "Poison", [json: gen_json] do
    Poison.Parser.parse!(json)
  end

  bench "jiffy", [json: gen_json] do
    :jiffy.decode(json, [:return_maps])
  end

  bench "JSEX", [json: gen_json] do
    JSEX.decode!(json)
  end

  # UTF8 escaping
  bench "UTF8 escaping (Poison)", [utf8: gen_utf8] do
    Poison.Parser.parse!(utf8)
  end

  bench "UTF8 escaping (jiffy)", [utf8: gen_utf8] do
    :jiffy.decode(utf8)
  end

  bench "UTF8 escaping (JSEX)", [utf8: gen_utf8] do
    JSEX.decode!(utf8)
  end

  defp gen_json do
    File.read!(Path.expand("data/generated.json", __DIR__))
  end

  defp gen_utf8 do
    text = File.read!(Path.expand("data/UTF-8-demo.txt", __DIR__))
    Poison.encode!(text) |> IO.iodata_to_binary
  end
end
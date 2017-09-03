defmodule Servy.Parser do
  @doc "Parses the request and sets an initial body and status."
  def parse(request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first
      |> String.split()

    %{ method: method,
       path: path,
       resp_body: "",
       status: nil
     }
  end  
end

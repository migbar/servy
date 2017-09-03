defmodule Servy.Router do
  alias Servy.Conv

  @pages_path Path.expand("../../pages", __DIR__)

  def route(%Conv{ method: "GET", path: "/about" } = conv) do
    @pages_path
    |> Path.join("about.html")
    |> File.read
    |> handle_file(conv)
  end

  def route(%Conv{ method: "GET", path: "/wildthings" } = conv) do
    %{ conv | status: 200, resp_body: "Bears, Tigers, Shrimps and Chimps" }
  end

  def route(%Conv{ method: "GET", path: "/bears" } = conv) do
    %{ conv | status: 200, resp_body: "Smokey, Peetey, Paddington" }
  end

  def route(%Conv{ method: "GET", path: "/bears/" <> id } = conv) do
    %{ conv | status: 200, resp_body: "Bear #{id}" }
  end

  # name=Baloo&type=Brown
  def route(%Conv{ method: "POST", path: "/bears"} = conv) do
    %{ conv | status: 201,
              resp_body: "Created a #{conv.params["type"]} Bear, named #{conv.params["name"]}!" }
  end

  def route(%Conv{ path: path } = conv) do
    %{ conv | status: 404, resp_body: "No #{path} here!" }
  end

  def handle_file({:ok, content}, conv) do
    %{ conv | status: 200, resp_body: content}
  end

  def handle_file({:error, :enoent}, conv) do
    %{ conv | status: 404, resp_body: "File not found!"}
  end

  def handle_file({:error, reason}, conv) do
    %{ conv | status: 500, resp_body: "File error: #{reason}"}
  end
end

defmodule Servy.Formatter do
  alias Servy.Conv
  
  def format_response(%Conv{} = conv) do
    content_length = String.length(conv.resp_body)
    """
    HTTP/1.1 #{Conv.full_status(conv)}
    Content-Type: text/html
    Content-Length: #{content_length}

    #{conv.resp_body}
    """
  end
end

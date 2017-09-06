defmodule Servy.Formatter do
  alias Servy.Conv

  def format_response(%Conv{} = conv) do
    content_length = String.length(conv.resp_body)
    """
    HTTP/1.1 #{Conv.full_status(conv)}\r
    Content-Type: #{conv.resp_content_type}\r
    Content-Length: #{content_length}\r
    \r
    #{conv.resp_body}
    """
  end
end

defmodule Blurg.Data do
  defmacro __using__([]) do
    quote do
      import unquote(__MODULE__)

      def build(conn, opts \\ nil) do
        action = Phoenix.Controller.action_name(conn)
        build(conn, action, opts)
      end
    end
  end

  def a(href), do: [href: href]
  def a(content, href, attrs \\ []), do: {content, a(href) ++ attrs}

  def form(action, method, fields \\ %{}) do
    content = Map.merge(fields, %{
      csrf: [name: "_csrf_token", value: Phoenix.Controller.get_csrf_token],
      method: [name: "_method", value: method],
    })
    {content, action: action, method: "post"}
  end
end

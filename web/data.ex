defmodule Blurg.Data do
  defmacro __using__([]) do
    quote do
      def build(conn, opts \\ nil) do
        action = Phoenix.Controller.action_name(conn)
        build(conn, action, opts)
      end
    end
  end
end

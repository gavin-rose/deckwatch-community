defmodule Deckcom.Task.Geniset do
    use GenServer

    def start_link do
        GenServer.start_link(__MODULE__, %{})
    end

    def init(_) do
        case :timer.send_interval(1000, :update) do
            {:ok} ->
                {:ok, "Task Completed by Geniset"}
            {:error} ->
                {:error, "Task NOT Completed by Geniset"}
        end
    end

    def handler(:update, msg) do
        {:ok, msg}
    end
end
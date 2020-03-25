defmodule Deckcom.Task.Geniset do
    use GenServer
    require Logger
    import IO.ANSI

    def start_link(task) do
        GenServer.start_link(__MODULE__, task)
    end

    def init(task) do
        IO.puts yellow <> "Geniset Starting..." <> white
        IO.puts yellow <> "Running" <> blue <> "#{task}" <> yellow <> " on bootup..." <> white
        :timer.send_after(1000, mask)
        IO.puts yellow <> "Task " <> blue <> "#{task}" <> yellow <> " Ran Successfully." <> white
        IO.puts yellow <> "Geniset Online, Initialization Complete." <> white
        :timer.send_interval(1000 * 60 * 60 * 24 * 7, mask)
        {:ok, task}
    end

    def handle_info(mask, task) do
        {:noreply, IO.puts yellow <> "Handled Task " <> blue <> "#{task}" <> yellow <> " at #{Time.utc_now}, Next Task Running Automatically in " <> green <> "#{1000 * 60 * 60 * 24 * 7} seconds " <> white <> "(One Week)."}
    end

    def manual(task) do
        branch = error
        case task do
            "cards" ->
                branch = mask
            _ ->
                branch = error
        end
        IO.puts yellow <> "Running " <> blue <> "#{task}" <> yellow <> " manually..." <> white
        :timer.send_after(1000, branch)
        if branch != error do 
            IO.puts yellow <> "Task " <> blue <> "#{task}" <> yellow <> " Ran Successfully." <> white
        end
    end
    
    def mask do
        Deckcom.Task.Test.log()
    end

    def error do
        IO.puts yellow <> "Task " <> " Failed to Run Manually." <> white
    end
end
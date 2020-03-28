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
        #:timer.send_after(1000, cards)
        IO.puts yellow <> "Task " <> blue <> "#{task}" <> yellow <> " Ran Successfully." <> white
        IO.puts yellow <> "Geniset Online, Initialization Complete." <> white
        :timer.send_interval(1000 * 60 * 60 * 24 * 7, [cards, :infinity])
    end

    def handle_info(task, params) do
        #case task do
        #    {:ok, :ok} ->
        #        {:noreply, IO.puts red <> "Default Task Running..."}
        #    _ ->
        #        {:noreply, IO.puts yellow <> "Handled Task " <> blue <> "#{task}" <> yellow <> " at #{Time.utc_now}, Next Task Running Automatically in " <> green <> "#{1000 * 60 * 60 * 24 * 7} seconds " <> white <> "(One Week)."}
        #end
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

    def cardsRetry(page) do
        Task.await(Task.start(Deckcom.Task.Cards.continue_card_db_copy(page)), :infinity)
        #Task.await(task, :infinity)
        {:ok, IO.puts yellow <> "Handled Task " <> blue <> "cards" <> yellow <> " at #{Time.utc_now}, Next Task Running Automatically in " <> green <> "#{1000 * 60 * 60 * 24 * 7} seconds " <> white <> "(One Week)."}
    end

    def cards do
        Task.await(Task.start(Deckcom.Task.Cards.start_card_db_copy()), :infinity)
        #Task.await(task, :infinity)
        {:ok, IO.puts yellow <> "Handled Task " <> blue <> "cards" <> yellow <> " at #{Time.utc_now}, Next Task Running Automatically in " <> green <> "#{1000 * 60 * 60 * 24 * 7} seconds " <> white <> "(One Week)."}
    end

    def mask do
        Deckcom.Task.Test.log()
    end

    def error do
        IO.puts yellow <> "Task " <> " Failed to Run Manually." <> white
    end
end
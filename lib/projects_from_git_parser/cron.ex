defmodule ProjectsFromGit.Cron do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    # Schedule work to be performed at some point
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    # Do the work
    ProjectsFromGit.Composer.start()
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work() do
    # Load data
    # :work, 23 * 60 * 60 * 1000
    Process.send_after(self(), :work, 23 * 60 * 60 * 1000)
  end
end

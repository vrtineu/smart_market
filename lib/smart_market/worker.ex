defmodule SmartMarket.Worker do
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(args) do
    # Immediately process a transaction upon worker initialization
    process_transaction()
    {:ok, args}
  end

  def handle_call(:process, _from, state) do
    # This could be a placeholder for more specific processing logic
    process_transaction()
    {:reply, :ok, state}
  end

  defp process_transaction do
    # Attempt to dequeue a transaction from the QueueManager
    case SmartMarket.QueueManager.dequeue_transaction() do
      nil ->
        IO.puts("No transactions to process.")

      transaction ->
        # Simulate processing the transaction
        IO.puts("Processing transaction: #{inspect(transaction)}")
        # Here you would implement your processing logic
    end
  end
end

defmodule SmartMarket.Processor do
  def process_transaction do
    Task.start(fn ->
      case SmartMarket.QueueManager.dequeue_transaction() do
        nil ->
          IO.puts("No transactions to process.")

        transaction ->
          IO.puts("Processing transaction: #{inspect(transaction)}")
      end
    end)
  end
end

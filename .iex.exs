## Old way using GenServer, ETS, and DynamicSupervisor
# using this after running `iex -S mix` will show the transaction data being enqueued, the ETS table contents, the transactions before processing, and the transactions after processing
# the process stay alive even after the transactions are processed

transaction_data = %{product_id: "123", client_id: "abc"}
enqueue = SmartMarket.QueueManager.enqueue_transaction(transaction_data)
IO.inspect(transaction_data, label: "Transaction Data Enqueued")

ets_table = :ets.tab2list(:transaction_queue)
IO.inspect(ets_table, label: "ETS Table Contents")

transactions_before = SmartMarket.QueueManager.peek_transaction_queue()
IO.inspect(transactions_before, label: "Transactions Before Processing")

{:ok, worker_pid} = DynamicSupervisor.start_child(SmartMarket.WorkerSupervisor, {SmartMarket.Worker, %{}})
transactions_after = SmartMarket.QueueManager.peek_transaction_queue()
IO.inspect(transactions_after, label: "Transactions After Processing")

IO.puts("Worker PID: #{inspect(worker_pid)}, Worker Alive: #{inspect(Process.alive?(worker_pid))}")

## New way using Task, and GenServer
# using this after running `iex -S mix` will show the transaction data being enqueued, the ETS table contents, the transactions before processing, and the transactions after processing
# the process will exit after the transactions are processed

IO.puts("Starting test using Task, and GenServer")

SmartMarket.QueueManager.enqueue_transaction(transaction_data)
IO.inspect(transaction_data, label: "Transaction Data Enqueued")

ets_table = :ets.tab2list(:transaction_queue)
IO.inspect(ets_table, label: "ETS Table Contents")

transactions_before = SmartMarket.QueueManager.peek_transaction_queue()
IO.inspect(transactions_before, label: "Transactions Before Processing")

SmartMarket.TransactionProcessor.process_transaction()
transactions_after = SmartMarket.QueueManager.peek_transaction_queue()
IO.inspect(transactions_after, label: "Transactions After Processing")


## Testing with concurrent transactions

for i <- 1..10 do
  data = %{product_id: "123", client_id: "abc-#{i}"}
  Task.start(fn -> SmartMarket.QueueManager.enqueue_transaction(data) end)
end

for _ <- 1..11 do
  Task.start(fn -> SmartMarket.TransactionProcessor.process_transaction() end)
end

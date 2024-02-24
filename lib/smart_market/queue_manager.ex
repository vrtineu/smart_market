defmodule SmartMarket.QueueManager do
  use GenServer

  # Public API
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{transaction_queue: [], transactions_processed: 0},
      name: __MODULE__
    )
  end

  def enqueue_transaction(transaction) do
    GenServer.cast(__MODULE__, {:enqueue_transaction, transaction})
  end

  def dequeue_transaction do
    GenServer.call(__MODULE__, :dequeue_transaction)
  end

  def peek_transaction_queue do
    GenServer.call(__MODULE__, :peek_transaction_queue)
  end

  # GenServer Callbacks
  def init(initial_state) do
    :ets.new(:transaction_queue, [:named_table, :ordered_set, :public])
    {:ok, initial_state}
  end

  def handle_cast({:enqueue_transaction, transaction}, state) do
    transaction_id = UUID.uuid4()
    updated_transaction = Map.put(transaction, :id, transaction_id)

    :ets.insert(:transaction_queue, {transaction_id, updated_transaction})
    new_queue = [updated_transaction | state.transaction_queue]
    {:noreply, %{state | transaction_queue: new_queue}}
  end

  def handle_call(:dequeue_transaction, _from, state) do
    case :ets.first(:transaction_queue) do
      :"$end_of_table" ->
        {:reply, nil, state}

      transaction_id ->
        [{_id, transaction}] = :ets.lookup(:transaction_queue, transaction_id)
        :ets.delete(:transaction_queue, transaction_id)
        # Ensure transactions_processed is initialized in the state, increment it here.
        new_state = Map.update!(state, :transactions_processed, &(&1 + 1))
        # Remove the transaction from the local state queue as well, if necessary.
        new_queue = Enum.reject(state.transaction_queue, fn t -> t.id == transaction_id end)
        {:reply, transaction, %{new_state | transaction_queue: new_queue}}
    end
  end

  def handle_call(:peek_transaction_queue, _from, state) do
    {:reply, state.transaction_queue, state}
  end
end

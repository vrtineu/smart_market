defmodule SmartMarket.QueueManager do
  use GenServer

  # Public API
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{transaction_queue: []}, name: __MODULE__)
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
    {:ok, initial_state}
  end

  def handle_cast({:enqueue_transaction, transaction}, state) do
    new_queue = [transaction | state.transaction_queue]
    {:noreply, %{state | transaction_queue: new_queue}}
  end

  def handle_call(:dequeue_transaction, _from, %{transaction_queue: []} = state) do
    {:reply, nil, state}
  end

  def handle_call(:dequeue_transaction, _from, state) do
    [next_transaction | rest_queue] = state.transaction_queue
    {:reply, next_transaction, %{state | transaction_queue: rest_queue}}
  end

  def handle_call(:peek_transaction_queue, _from, state) do
    {:reply, state.transaction_queue, state}
  end
end

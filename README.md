# SmartMarket

SmartMarket is an Elixir-based project designed as a learning sandbox for exploring the capabilities of Elixir and OTP. It simulates a smart market system where transactions are processed asynchronously, showcasing Elixir's concurrency model and fault-tolerance mechanisms.

## Project Overview

The project simulates a smart market system, devoid of on-site employees, where customers can pick items off the shelf, and the transactions are handled entirely through IoT devices and backend systems. Utilizing Elixir's OTP framework, it demonstrates a robust system capable of queue management, dynamic worker processes for transaction processing, and fault tolerance.

## Installation

### Prerequisites

- Elixir 1.11 or later
- Erlang/OTP 23 or later

### Setup

Install dependencies:

```bash
mix deps.get
```

Compile the project:

```bash
mix compile
```

Run the project:

```bash
iex -S mix
```

## Interacting with the System

To enqueue a transaction, use the `SmartMarket.QueueManager.enqueue_transaction/1`

```elixir
SmartMarket.QueueManager.enqueue_transaction(%{client_id: "abc", product_id: "123"})
```

To process the transactions, use the `SmartMarket.TransactionProcessor.process_transaction/0`

```elixir
SmartMarket.TransactionProcessor.process_transaction()
```

## Learning Objectives

- OTP Concurrency: Demonstrates how to leverage OTP for building concurrent applications in Elixir.
- Fault Tolerance: Showcases Elixir's fault-tolerance capabilities through process supervision and recovery.
- Dynamic Supervision: Uses a DynamicSupervisor to start worker processes dynamically for transaction processing.
- Asynchronous Task Processing: Implements Task for asynchronous transaction processing, highlighting the ease of concurrent task management in Elixir.

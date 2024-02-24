defmodule SmartMarket.Transactions do
  @moduledoc """
  The Transactions context.
  """

  import Ecto.Query, warn: false

  alias SmartMarket.Repo
  alias SmartMarket.Models.Transaction

  @doc """
  List all transactions.

  ## Examples

      iex> SmartMarket.Transactions.list_transactions()
      [%Transaction{}, %Transaction{}]

  """
  def list_transactions do
    Repo.all(Transaction)
  end

  @doc """
  Get a transaction by ID.

  ## Examples

      iex> SmartMarket.Transactions.get_transaction!(1)
      %Transaction{}

  """
  def get_transaction!(id) do
    Repo.get!(Transaction, id)
  end

  @doc """
  Create a transaction.

  ## Examples

      iex> SmartMarket.Transactions.create_transaction(%{customer_id: "1", status: "pending"})
      {:ok, %Transaction{}}

  """
  def create_transaction(attrs \\ %{}) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Update a transaction.

  ## Examples

      iex> SmartMarket.Transactions.update_transaction(%Transaction{}, %{status: "completed"})
      {:ok, %Transaction{}}

  """
  def update_transaction(%Transaction{} = transaction, attrs) do
    transaction
    |> Transaction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete a transaction.

  ## Examples

      iex> SmartMarket.Transactions.delete_transaction!(%Transaction{})
      %Transaction{}

  """
  def delete_transaction!(id) do
    transaction = get_transaction!(id)
    Repo.delete!(transaction)
  end
end

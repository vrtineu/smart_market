defmodule SmartMarket.Transactions do
  @moduledoc """
  The Transactions context.
  """

  import Ecto.Query, warn: false

  alias SmartMarket.Repo
  alias SmartMarket.Models.Transaction

  def list_transactions do
    Repo.all(Transaction)
  end

  def get_transaction!(id) do
    Repo.get!(Transaction, id)
  end

  def create_transaction(attrs \\ %{}) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
  end

  def update_transaction(%Transaction{} = transaction, attrs) do
    transaction
    |> Transaction.changeset(attrs)
    |> Repo.update()
  end

  def delete_transaction!(id) do
    transaction = get_transaction!(id)
    Repo.delete!(transaction)
  end
end

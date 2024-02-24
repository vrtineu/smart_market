defmodule SmartMarket.Models.Transaction do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field(:customer_id, :string)
    field(:status, :string, default: "pending")
    has_many(:transaction_products, SmartMarket.Models.TransactionProducts)

    timestamps()
  end

  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:customer_id, :status])
    |> validate_required([:customer_id, :status])
  end
end

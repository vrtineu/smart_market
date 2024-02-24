defmodule SmartMarket.Models.TransactionProducts do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "transaction_products" do
    field(:quantity, :integer)
    belongs_to(:transaction, SmartMarket.Models.Transaction)
    belongs_to(:product, SmartMarket.Models.Product)

    timestamps()
  end

  def changeset(transaction_product, attrs) do
    transaction_product
    |> cast(attrs, [:quantity, :transaction_id, :product_id])
    |> validate_required([:quantity, :transaction_id, :product_id])
  end
end

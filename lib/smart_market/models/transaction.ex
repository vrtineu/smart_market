defmodule SmartMarket.Models.Transaction do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "transactions" do
    field(:customer_id, :binary_id)
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

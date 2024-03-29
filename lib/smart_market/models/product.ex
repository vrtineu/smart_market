defmodule SmartMarket.Models.Product do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "products" do
    field(:name, :string)
    field(:price, :decimal)
    has_many(:transaction_products, SmartMarket.Models.TransactionProducts)

    timestamps()
  end

  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :quantity])
    |> validate_required([:name, :price, :quantity])
  end
end

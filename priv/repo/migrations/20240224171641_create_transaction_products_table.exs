defmodule SmartMarket.Repo.Migrations.CreateTransactionProductsTable do
  use Ecto.Migration

  def change do
    create table(:transaction_products, primary_key: false) do
      add :transaction_id, references(:transactions, on_delete: :delete_all), type: :uuid, null: false
      add :product_id, references(:products, on_delete: :delete_all), type: :uuid, null: false
      add :quantity, :integer, null: false, default: 1

      timestamps()
    end
  end
end

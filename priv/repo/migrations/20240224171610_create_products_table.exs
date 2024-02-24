defmodule SmartMarket.Repo.Migrations.CreateProductsTable do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string, null: false
      add :price, :decimal, null: false

      timestamps()
    end
  end
end

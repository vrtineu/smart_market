defmodule SmartMarket.Repo.Migrations.CreateTransactionsTable do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :customer_id, :uuid, null: false
      add :status, :string, null: false, default: "pending"

      timestamps()
    end
  end
end

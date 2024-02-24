defmodule SmartMarket.Products do
  @moduledoc """
  The Products context.
  """

  import Ecto.Query, warn: false

  alias SmartMarket.Repo
  alias SmartMarket.Models.Product

  def list_products do
    Repo.all(Product)
  end

  def get_product!(id) do
    Repo.get!(Product, id)
  end

  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  def delete_product!(id) do
    product = get_product!(id)
    Repo.delete!(product)
  end
end

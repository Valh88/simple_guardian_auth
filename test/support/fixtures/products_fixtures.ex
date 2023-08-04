defmodule SimpleGuardianAuth.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SimpleGuardianAuth.Products` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> SimpleGuardianAuth.Products.create_product()

    product
  end
end

defmodule SimpleGuardianAuthWeb.ErrorJSONTest do
  use SimpleGuardianAuthWeb.ConnCase, async: true

  test "renders 404" do
    assert SimpleGuardianAuthWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert SimpleGuardianAuthWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end

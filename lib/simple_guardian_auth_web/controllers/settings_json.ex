defmodule SimpleGuardianAuthWeb.SettingsJSON do

  def get_user(%{user: user}) do
    %{
      user: user.email,
      id: user.id
    }
  end
end

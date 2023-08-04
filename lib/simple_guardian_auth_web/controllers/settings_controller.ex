defmodule SimpleGuardianAuthWeb.SettingsController do
  use SimpleGuardianAuthWeb, :controller

  alias SimpleGuardianAuth.Accounts
  alias SimpleGuardianAuth.Accounts.Account
  alias SimpleGuardianAuthWeb.Security.Guardian
  alias SimpleGuardianAuthWeb.Security.ErrorResponse

  action_fallback SimpleGuardianAuthWeb.FallbackController

  #plug :change_email when action in [:change_email]

  def get_current_user(conn, _params) do
    if conn.assigns[:current_user] != [] do
      render(conn, :get_user, user: conn.assigns.current_user)
    else
      {:error, :unauthorized}
    end
  end

  def get_user_by_id(conn, %{"id" => id}) do
    try do
      account = Accounts.get_account!(id)
      render(conn, :get_user, user: account)
    rescue
      _  -> {:error, :not_found}
      #Ecto.Query.CastError -> {:error, :not_found}
    end

  end

  def change_email(conn, %{"change_email" => params}) do
    %{"email" => email} = params
    IO.inspect(email)
    with {:ok, %Account{} = account} <- Accounts.update_account(conn.assigns.current_user, %{email: email}) do
        render(conn, :get_user, user: account)
    end
  end

end

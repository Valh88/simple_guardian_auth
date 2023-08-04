defmodule SimpleGuardianAuthWeb.AccountController do
  use SimpleGuardianAuthWeb, :controller

  alias SimpleGuardianAuth.Accounts
  alias SimpleGuardianAuth.Accounts.Account
  alias SimpleGuardianAuthWeb.Security.Guardian
  alias SimpleGuardianAuthWeb.Security.ErrorResponse

  action_fallback SimpleGuardianAuthWeb.FallbackController

  def test(conn, _params) do
    render(conn, :test, test: "test")
  end

  def create(conn, %{"account" => account_params}) do
    %{"email" => email, "password" => pass} = account_params
    with {:ok, %Account{} = account}  <- Accounts.create_account(
      %{email: email, password_hash: pass}
      ) do
        render(conn, :account, account: account)
    end
  end

  def sign_in(conn, %{"sign_params" => sign_params}) do
    %{"email" => email, "password" => password} = sign_params
    case Guardian.authenticate(email, password) do
      {:ok, account, token} ->
        conn
        #|> Plug.Conn.put_session(:account_id, account.id)
        |> put_status(:ok)
        |> render(:account_token, %{account: account, token: token})
      {:error, :unauthorized} ->
        raise ErrorResponse.Unauthorized, message: "Email or Password incorrect."
    end
  end
end

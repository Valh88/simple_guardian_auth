defmodule SimpleGuardianAuthWeb.Security.Guardian do
  @moduledoc """
  false
  """
  use Guardian, otp_app: :simple_guardian_auth
  alias SimpleGuardianAuth.Accounts.Account
  alias SimpleGuardianAuth.Accounts

  def subject_for_token(%Account{} = account, _claims) do
    #IO.inspect(account)
    sub = to_string(account.id)
    IO.inspect(sub)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :no_id_provided}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_account!(id) do
      nil -> {:error, :not_found}
      account -> {:ok, account}
    end
  end

  def resource_from_claims(_claims) do
    {:error, :no_id_provided}
  end

  def authenticate(email, password) do
    case Accounts.get_account_by_email(email) do
      nil ->
        {:error, :not_found}
      account ->
        case check_password(password, account.password_hash) do
          true -> create_token(account, :access)
          false -> {:error, :unauthorized}
        end
    end
  end

  def check_password(password, hash_password) do
    Argon2.verify_pass(password, hash_password)
  end


  defp create_token(account, type) do
    {:ok, token, _claims} = encode_and_sign(account, %{}, token_options(type))
    {:ok, account, token}
  end

  defp token_options(type) do
    case type do
      :access -> [token_type: "access", ttl: {2, :hour}]
      :reset -> [token_type: "reset", ttl: {15, :minute}]
      :admin -> [token_type: "admin", ttl: {90, :day}]
    end
  end
end

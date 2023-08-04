defmodule SimpleGuardianAuthWeb.AccountJSON do
  alias SimpleGuardianAuth.Accounts.Account

  def test(%{test: test}) do
    %{
      test: test
    }
  end

  def account(%{account: account}) do
    %Account{} = account
    %{
      email: account.email
    }
  end

  def account_token(%{account: account, token: token}) do
    %{
      account: %{
        email: account.email,
        token: token
      }
    }
  end
end

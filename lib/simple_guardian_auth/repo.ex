defmodule SimpleGuardianAuth.Repo do
  use Ecto.Repo,
    otp_app: :simple_guardian_auth,
    adapter: Ecto.Adapters.Postgres
end

defmodule SimpleGuardianAuthWeb.Security.Pipeline do
  @moduledoc """
  false
  """
  use Guardian.Plug.Pipeline, otp_app: :simple_guardian_auth,
  module: SimpleGuardianAuthWeb.Security.Guardian,
  error_handler: SimpleGuardianAuthWeb.Security.GuardianErrorHandler

  # plug Guardian.Plug.VerifySession
  # plug Guardian.Plug.VerifyHeader
  # plug Guardian.Plug.EnsureAuthenticated
  # plug Guardian.Plug.LoadResource
end

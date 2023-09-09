defmodule SimpleGuardianAuthWeb.Security.SetCurrentUser do
  @moduledoc """
  false
  """
  import Plug.Conn
  alias SimpleGuardianAuthWeb.Security.Guardian
  alias SimpleGuardianAuthWeb.Security.ErrorResponse

  def init(_opt) do
  end

  def call(conn, _opt) do
    if conn.assigns[:current_user] != nil do
      conn
    else
      user = get_user(conn)
      if user == nil, do: raise ErrorResponse.Unauthorized
      assign(conn, :current_user, user)
    end
  end

  defp get_user(conn) do
    with  ["Bearer " <> token] <- get_req_header(conn, "authorization"),
          {:ok, claims} <- Guardian.decode_and_verify(token),
          {:ok, current_user} <- Guardian.resource_from_claims(claims) do
      current_user
    end
  end
end

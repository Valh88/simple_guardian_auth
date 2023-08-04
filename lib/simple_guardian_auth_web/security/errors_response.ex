defmodule SimpleGuardianAuthWeb.Security.ErrorResponse.Unauthorized do
  defexception [message: "Unauthorized", plug_status: 401]
end

defmodule SimpleGuardianAuthWeb.Security.ErrorResponse.NotFound do
  defexception [message: "Not Found", plug_status: 404]
end

defmodule SimpleGuardianAuthWeb.Security.ErrorResponse.Forbidden do
  defexception [message: "You do not have access to this resource.", plug_status: 403]
end

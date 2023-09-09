defmodule SimpleGuardianAuthWeb.ChatChannel do
  @moduledoc false
  use Phoenix.Channel
  #inspect("user_joined")

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end

  def join("room:" <> chat, _payload, socket) do
    {:ok, socket}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast!(socket, "new_msg", %{body: body})
    {:noreply, socket}
  end

  # def handle_out("user_joined", msg, socket) do
  #   if Accounts.ignoring_user?(socket.assigns[:user], msg.user_id) do
  #     {:noreply, socket}
  #   else
  #     push(socket, "user_joined", msg)
  #     {:noreply, socket}
  #   end
  # end
end

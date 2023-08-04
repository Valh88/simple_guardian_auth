defmodule SimpleGuardianAuth.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SimpleGuardianAuthWeb.Telemetry,
      # Start the Ecto repository
      SimpleGuardianAuth.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: SimpleGuardianAuth.PubSub},
      # Start Finch
      {Finch, name: SimpleGuardianAuth.Finch},
      # Start the Endpoint (http/https)
      SimpleGuardianAuthWeb.Endpoint
      # Start a worker by calling: SimpleGuardianAuth.Worker.start_link(arg)
      # {SimpleGuardianAuth.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SimpleGuardianAuth.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SimpleGuardianAuthWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

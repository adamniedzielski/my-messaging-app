defmodule MyMessagingApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MyMessagingAppWeb.Telemetry,
      MyMessagingApp.Repo,
      {DNSCluster, query: Application.get_env(:my_messaging_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MyMessagingApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MyMessagingApp.Finch},
      # Start a worker by calling: MyMessagingApp.Worker.start_link(arg)
      # {MyMessagingApp.Worker, arg},
      # Start to serve requests, typically the last entry
      MyMessagingAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MyMessagingApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MyMessagingAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

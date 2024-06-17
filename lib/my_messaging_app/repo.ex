defmodule MyMessagingApp.Repo do
  use Ecto.Repo,
    otp_app: :my_messaging_app,
    adapter: Ecto.Adapters.Postgres
end

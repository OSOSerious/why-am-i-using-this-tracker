defmodule WhyAmIUsingThisTrackerWeb do
  use Phoenix.Endpoint, otp_app: :why_am_i_using_this_tracker

  socket "/socket", WhyAmIUsingThisTrackerWeb.UserSocket,
    websocket: true,
    longpoll: false

  plug Plug.Static,
    at: "/",
    from: :why_am_i_using_this_tracker,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, store: :cookie, key: "_why_am_i_using_this_tracker_key", signing_salt: "change_me"

  plug WhyAmIUsingThisTrackerWeb.Router
end

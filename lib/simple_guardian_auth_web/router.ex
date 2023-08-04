defmodule SimpleGuardianAuthWeb.Router do
  use SimpleGuardianAuthWeb, :router
  # use Plug.ErrorHandler

  # def handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
  #   conn |> json(%{errors: message}) |> halt()
  # end

  # def handle_errors(conn, %{reason: %{message: message}}) do
  #   conn |> json(%{errors: message}) |> halt()
  # end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {SimpleGuardianAuthWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    #plug SimpleGuardianAuthWeb.Security.Pipeline
    plug SimpleGuardianAuthWeb.Security.SetCurrentUser
  end

  scope "/api", SimpleGuardianAuthWeb do
    pipe_through :api

    resources "/products", ProductController, except: [:new, :edit]

    get "/account", AccountController, :test
    post "/create" , AccountController, :create
    post "/sign_in", AccountController, :sign_in
  end

  scope "/api", SimpleGuardianAuthWeb do
    pipe_through [:api, :auth]

    get "/current_user", SettingsController, :get_current_user
    post "/current_user", SettingsController, :change_email
    get "/user/:id", SettingsController, :get_user_by_id
  end

  scope "/", SimpleGuardianAuthWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", SimpleGuardianAuthWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:simple_guardian_auth, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: SimpleGuardianAuthWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end

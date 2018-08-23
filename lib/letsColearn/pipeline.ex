defmodule LetsColearn.Pipeline do
    use Guardian.Plug.Pipeline,
        otp_app: :letsColearn,
        error_handler: LetsColearn.AuthErrorHandler,
        module: LetsColearn.Guardian

    plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
    plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
    plug Guardian.Plug.LoadResource, allow_blank: true
end
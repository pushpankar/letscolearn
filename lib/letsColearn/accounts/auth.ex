defmodule LetsColearn.Accounts.Auth do
    
    alias LetsColearn.Accounts
    alias LetsColearn.Accounts.Credential
    alias LetsColearn.Repo
    
    def authenticate(%{"password" => password, "email" => email}) do
        user = Accounts.get_user_by_email(String.downcase(email))
        case verify(user, password) do
            true -> {:ok, user}
            {:user_error, err} -> {:error, err}
            _    -> {:error, "password did not match"}
        end
    end

    defp verify(user, password) do
        case user do
            nil -> {:user_error, "User does not exist"}
            _   -> Comeonin.Bcrypt.checkpw(password, user.credential.password_hash)
        end
    end
end
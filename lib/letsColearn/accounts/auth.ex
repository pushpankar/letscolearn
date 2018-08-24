defmodule LetsColearn.Accounts.Auth do
    alias LetsColearn.Accounts.User
    alias LetsColearn.Repo
    
    def login(%{"user" => %{"credential" => %{"password" => password, "email" => email}}}) do
        user = Repo.get_by(User, email: String.downcase(email))
        case authenticate(user, password) do
            true -> {:ok, user}
            {:user_error, err} -> {:error, err}
            _    -> {:error, "password did not match"}
        end
    end

    defp authenticate(user, password) do
        case user do
            nil -> {:user_error, "User does not exist"}
            _   -> Comeonin.Bcrypt.checkpw(password, user.credential.password_hash)
        end
    end
end
defmodule LetsColearn.Accounts.Auth do
    
    alias LetsColearn.Accounts
    alias LetsColearn.Cohorts
    require IEx
    
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

    def has_joined?(%{"conn" => conn, "cohort_id" => cohort_id}) do
        cohort = Cohorts.get_cohort!(cohort_id)
        user = Guardian.Plug.current_resource(conn)
        IO.puts(cohort_id)
        IO.puts(user.id)
        if Enum.any?(cohort.users, &(&1.id == user.id)) do
            true
        else
            false
        end
    end

    # @TODO maybe I can check user's cohort has cohort_id or not. That might be more efficent
    def has_joined?(user, cohort_id) do
        cohort = Cohorts.get_cohort!(cohort_id)
        if Enum.any?(cohort.users, &(&1.id == user.id)) do
            {:ok}
        else
            {:error}
        end
    end


    def match_user(conn, user_id) do
        user = Guardian.Plug.current_resource(conn)
        if user.id == user_id do
            true
        else
            false
        end

    end
end
defmodule LetsColearn.Accounts.Auth do
    
    alias LetsColearn.Accounts
    alias LetsColearn.Cohorts
    alias LetsColearn.Aim.Goal
    alias LetsColearn.Repo
    require IEx
    import Ecto.Query, only: [from: 2]
    
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

    def has_joined?(conn, goal) do
        user = Guardian.Plug.current_resource(conn)
        if !!user do
            query = from u in LetsColearn.Aim.GoalUser, where: u.user_id == ^user.id and u.goal_id == ^goal.id
            length(Repo.all(query)) > 0 
        else
            false
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

    def creator?(conn, %Goal{} = goal) do
        maybe_user = Guardian.Plug.current_resource(conn)
        !!maybe_user and maybe_user.id == goal.creator.id
    end


end
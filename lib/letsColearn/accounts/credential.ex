defmodule LetsColearn.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset

  alias LetsColearn.Accounts.User

  schema "credentials" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    belongs_to :user, User

    timestamps()
  end

  @doc false
  defp changeset_email(credential, attrs) do
    credential
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> unique_constraint(:email)
  end

  # This should be used by default
  def changeset(struct, params) do
    struct
    |> changeset_email(params)
    |> cast(params, [:password])
    |> validate_length(:password, min: 6, max: 100)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end

end

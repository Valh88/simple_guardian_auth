defmodule SimpleGuardianAuth.Accounts.Account do
  @moduledoc """
    false
  """
  use Ecto.Schema
  import Ecto.Changeset

  @optional_fields [:id, :inserted_at, :updated_at]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :email, :string
    field :password_hash, :string

    timestamps()
  end

  defp all_fields do
    __MODULE__.__schema__(:fields)
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, all_fields())
    |> validate_required(all_fields() -- @optional_fields)
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(
    %Ecto.Changeset{valid?: true, changes: %{password_hash: password}} = changeset
    ) do
    change(changeset, Argon2.add_hash(password))
    #change(changeset, Argon2.add_hash(password))
    #change(changeset, hash_password: Bcrypt.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset


end

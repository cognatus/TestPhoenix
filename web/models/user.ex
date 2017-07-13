defmodule Test.User do
  use Test.Web, :model

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string
    field :password_virtual, :string, virtual: true

    has_many :notes, Test.Note

    timestamps()
  end

  @required_fields ~w(email)a
  @optional_fields ~w(name)a
  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

  def registration_changeset(struct, params) do
    struct
    |> changeset(params)
    |> cast(params, ~w(password_virtual)a, [])
    |> validate_length(:password_virtual, min: 6, max: 100)
    |> hash_password
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true,
                      changes: %{password_virtual: password_virtual}} ->
        put_change(changeset,
                   :password,
                   Comeonin.Bcrypt.hashpwsalt(password_virtual))
      _ ->
        changeset
    end
  end

end

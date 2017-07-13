defmodule Test.Note do
  use Test.Web, :model

  schema "notes" do
    field :course, :string
    field :note, :integer
    belongs_to :user, Test.User

    timestamps()
  end

  @required_fields ~w(course)a
  @optional_fields ~w(note)a

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:user)
  end
end

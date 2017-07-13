defmodule Test.NoteTest do
  use Test.ModelCase

  alias Test.Note

  @valid_attrs %{course: "some content", note: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Note.changeset(%Note{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Note.changeset(%Note{}, @invalid_attrs)
    refute changeset.valid?
  end
end

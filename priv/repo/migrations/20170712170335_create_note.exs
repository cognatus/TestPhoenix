defmodule Test.Repo.Migrations.CreateNote do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :course, :string
      add :note, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:notes, [:user_id])

  end
end

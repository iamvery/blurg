defmodule Blurg.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :text, null: false
      add :post_id, references(:posts, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:comments, [:post_id])
  end
end

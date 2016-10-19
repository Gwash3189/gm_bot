defmodule GmBot.Repo.Migrations.AddCharacterTable do
  use Ecto.Migration

  def change do
    create table(:characters) do
      add :name, :string
      add :owner, :string
      add :current_hp, :integer, default: 0
      add :max_hp, :integer, default: 0

      timestamps
    end

    create unique_index(:characters, [:name])
  end
end

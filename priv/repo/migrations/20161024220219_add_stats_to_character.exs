defmodule GmBot.Repo.Migrations.AddStatsToCharacter do
  use Ecto.Migration

  def change do
    alter table(:characters) do
      add :strength, :integer
      add :dexterity, :integer
      add :constitution, :integer
      add :intelligence, :integer
      add :wisdom, :integer
      add :charisma, :integer
    end
  end
end

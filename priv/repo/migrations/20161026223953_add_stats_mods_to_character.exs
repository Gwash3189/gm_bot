defmodule GmBot.Repo.Migrations.AddStatsModsToCharacter do
  use Ecto.Migration

  def change do
    alter table(:characters) do
      add :strength_modifier, :integer
      add :dexterity_modifier, :integer
      add :constitution_modifier, :integer
      add :intelligence_modifier, :integer
      add :wisdom_modifier, :integer
      add :charisma_modifier, :integer
    end
  end
end

defmodule TestHelpers do
  import Ecto.Query

  def start_db do
    children = [
      Supervisor.Spec.worker(GmBot.Repo, [])
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
    Application.ensure_started(GmBot.Repo)
    :ok
  end
end

defmodule TestHelpers.ModelCase do
  @moduledoc """
  This module defines the test case to be used by
  model tests.

  You may define functions here to be used as helpers in
  your model tests. See `errors_on/2`'s definition as reference.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      alias GmBot.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import TestHelpers.ModelCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(GmBot.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(GmBot.Repo, {:shared, self()})
    end

    :ok
  end
end

TestHelpers.start_db
ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(GmBot.Repo, :manual)

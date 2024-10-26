defmodule WhyAmIUsingThisTrackerWeb.GamificationData do
  use Ecto.Schema
  import Ecto.Changeset

  schema "gamification_data" do
    field :user_id, :integer
    field :reward_points, :integer
    field :challenges_completed, :integer
    field :leaderboard_position, :integer

    timestamps()
  end

  @doc false
  def changeset(gamification_data, attrs) do
    gamification_data
    |> cast(attrs, [:user_id, :reward_points, :challenges_completed, :leaderboard_position])
    |> validate_required([:user_id, :reward_points, :challenges_completed, :leaderboard_position])
  end

  def create_gamification_data(attrs \\ %{}) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def list_gamification_data do
    Repo.all(__MODULE__)
  end

  def get_gamification_data!(id) do
    Repo.get!(__MODULE__, id)
  end

  def update_gamification_data(gamification_data, attrs) do
    gamification_data
    |> changeset(attrs)
    |> Repo.update()
  end

  def delete_gamification_data(gamification_data) do
    Repo.delete(gamification_data)
  end
end

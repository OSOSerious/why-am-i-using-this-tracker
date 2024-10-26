defmodule WhyAmIUsingThisTrackerWeb.GamificationController do
  use WhyAmIUsingThisTrackerWeb, :controller

  alias WhyAmIUsingThisTracker.Gamification
  alias WhyAmIUsingThisTracker.GamificationData

  def index(conn, _params) do
    gamification_data = Gamification.list_gamification_data()
    render(conn, "index.json", gamification_data: gamification_data)
  end

  def create(conn, %{"gamification_data" => gamification_data_params}) do
    with {:ok, %GamificationData{} = gamification_data} <- Gamification.create_gamification_data(gamification_data_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.gamification_path(conn, :show, gamification_data))
      |> render("show.json", gamification_data: gamification_data)
    end
  end

  def show(conn, %{"id" => id}) do
    gamification_data = Gamification.get_gamification_data!(id)
    render(conn, "show.json", gamification_data: gamification_data)
  end

  def update(conn, %{"id" => id, "gamification_data" => gamification_data_params}) do
    gamification_data = Gamification.get_gamification_data!(id)

    with {:ok, %GamificationData{} = gamification_data} <- Gamification.update_gamification_data(gamification_data, gamification_data_params) do
      render(conn, "show.json", gamification_data: gamification_data)
    end
  end

  def delete(conn, %{"id" => id}) do
    gamification_data = Gamification.get_gamification_data!(id)

    with {:ok, %GamificationData{}} <- Gamification.delete_gamification_data(gamification_data) do
      send_resp(conn, :no_content, "")
    end
  end

  def manage_rewards(conn, %{"user_id" => user_id, "reward_points" => reward_points}) do
    case Gamification.update_reward_points(user_id, reward_points) do
      {:ok, _reward} ->
        send_resp(conn, :ok, "Rewards updated successfully")
      {:error, _changeset} ->
        send_resp(conn, :unprocessable_entity, "Failed to update rewards")
    end
  end

  def manage_challenges(conn, %{"user_id" => user_id, "challenges_completed" => challenges_completed}) do
    case Gamification.update_challenges_completed(user_id, challenges_completed) do
      {:ok, _challenge} ->
        send_resp(conn, :ok, "Challenges updated successfully")
      {:error, _changeset} ->
        send_resp(conn, :unprocessable_entity, "Failed to update challenges")
    end
  end

  def manage_leaderboards(conn, %{"user_id" => user_id, "leaderboard_position" => leaderboard_position}) do
    case Gamification.update_leaderboard_position(user_id, leaderboard_position) do
      {:ok, _leaderboard} ->
        send_resp(conn, :ok, "Leaderboard position updated successfully")
      {:error, _changeset} ->
        send_resp(conn, :unprocessable_entity, "Failed to update leaderboard position")
    end
  end
end

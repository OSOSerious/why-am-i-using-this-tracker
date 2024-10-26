defmodule WhyAmIUsingThisTrackerWeb.MoodController do
  use WhyAmIUsingThisTrackerWeb, :controller

  alias WhyAmIUsingThisTracker.MoodData

  def log_mood(conn, %{"mood" => mood}) do
    case MoodData.create_mood(%{mood: mood}) do
      {:ok, _mood} ->
        conn
        |> put_status(:created)
        |> json(%{message: "Mood logged successfully"})
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset})
    end
  end

  def get_mood(conn, _params) do
    moods = MoodData.list_moods()
    json(conn, moods)
  end
end

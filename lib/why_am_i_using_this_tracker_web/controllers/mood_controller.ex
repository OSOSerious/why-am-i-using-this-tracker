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

  def index(conn, _params) do
    moods = MoodData.list_moods()
    render(conn, "index.json", moods: moods)
  end

  def create(conn, %{"mood" => mood_params}) do
    case MoodData.create_mood(mood_params) do
      {:ok, mood} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.mood_path(conn, :show, mood))
        |> render("show.json", mood: mood)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset})
    end
  end

  def show(conn, %{"id" => id}) do
    mood = MoodData.get_mood!(id)
    render(conn, "show.json", mood: mood)
  end
end

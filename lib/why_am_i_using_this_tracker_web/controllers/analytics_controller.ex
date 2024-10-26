defmodule WhyAmIUsingThisTrackerWeb.AnalyticsController do
  use WhyAmIUsingThisTrackerWeb, :controller

  alias WhyAmIUsingThisTracker.AnalyticsData

  def track_user_engagement(conn, %{"user_id" => user_id, "engagement" => engagement}) do
    case AnalyticsData.create_engagement(%{user_id: user_id, engagement: engagement}) do
      {:ok, _engagement} ->
        send_resp(conn, :created, "User engagement tracked successfully")
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset})
    end
  end

  def track_session_duration(conn, %{"user_id" => user_id, "duration" => duration}) do
    case AnalyticsData.create_session_duration(%{user_id: user_id, duration: duration}) do
      {:ok, _duration} ->
        send_resp(conn, :created, "Session duration tracked successfully")
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset})
    end
  end

  def track_app_usage_patterns(conn, %{"user_id" => user_id, "app_usage" => app_usage}) do
    case AnalyticsData.create_app_usage_pattern(%{user_id: user_id, app_usage: app_usage}) do
      {:ok, _app_usage} ->
        send_resp(conn, :created, "App usage pattern tracked successfully")
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset})
    end
  end

  def index(conn, _params) do
    analytics_data = AnalyticsData.list_analytics_data()
    render(conn, "index.json", analytics_data: analytics_data)
  end

  def create(conn, %{"analytics_data" => analytics_data_params}) do
    with {:ok, %AnalyticsData{} = analytics_data} <- AnalyticsData.create_analytics_data(analytics_data_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.analytics_path(conn, :show, analytics_data))
      |> render("show.json", analytics_data: analytics_data)
    else
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset})
    end
  end

  def show(conn, %{"id" => id}) do
    analytics_data = AnalyticsData.get_analytics_data!(id)
    render(conn, "show.json", analytics_data: analytics_data)
  end

  def update(conn, %{"id" => id, "analytics_data" => analytics_data_params}) do
    analytics_data = AnalyticsData.get_analytics_data!(id)

    with {:ok, %AnalyticsData{} = analytics_data} <- AnalyticsData.update_analytics_data(analytics_data, analytics_data_params) do
      render(conn, "show.json", analytics_data: analytics_data)
    else
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset})
    end
  end

  def delete(conn, %{"id" => id}) do
    analytics_data = AnalyticsData.get_analytics_data!(id)

    with {:ok, %AnalyticsData{}} <- AnalyticsData.delete_analytics_data(analytics_data) do
      send_resp(conn, :no_content, "")
    else
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset})
    end
  end
end

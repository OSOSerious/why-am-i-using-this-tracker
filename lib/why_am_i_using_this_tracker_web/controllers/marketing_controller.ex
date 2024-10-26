defmodule WhyAmIUsingThisTrackerWeb.MarketingController do
  use WhyAmIUsingThisTrackerWeb, :controller

  alias WhyAmIUsingThisTracker.MarketingData

  def index(conn, _params) do
    marketing_data = MarketingData.list_marketing_data()
    render(conn, "index.json", marketing_data: marketing_data)
  end

  def create(conn, %{"marketing_data" => marketing_data_params}) do
    with {:ok, %MarketingData{} = marketing_data} <- MarketingData.create_marketing_data(marketing_data_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.marketing_path(conn, :show, marketing_data))
      |> render("show.json", marketing_data: marketing_data)
    end
  end

  def show(conn, %{"id" => id}) do
    marketing_data = MarketingData.get_marketing_data!(id)
    render(conn, "show.json", marketing_data: marketing_data)
  end

  def update(conn, %{"id" => id, "marketing_data" => marketing_data_params}) do
    marketing_data = MarketingData.get_marketing_data!(id)

    with {:ok, %MarketingData{} = marketing_data} <- MarketingData.update_marketing_data(marketing_data, marketing_data_params) do
      render(conn, "show.json", marketing_data: marketing_data)
    end
  end

  def delete(conn, %{"id" => id}) do
    marketing_data = MarketingData.get_marketing_data!(id)

    with {:ok, %MarketingData{}} <- MarketingData.delete_marketing_data(marketing_data) do
      send_resp(conn, :no_content, "")
    end
  end
end

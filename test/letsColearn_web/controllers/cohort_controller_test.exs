defmodule LetsColearnWeb.CohortControllerTest do
  use LetsColearnWeb.ConnCase

  alias LetsColearn.Cohorts

  @create_attrs %{description: "some description", title: "some title"}
  @update_attrs %{description: "some updated description", title: "some updated title"}
  @invalid_attrs %{description: nil, title: nil}

  def fixture(:cohort) do
    {:ok, cohort} = Cohorts.create_cohort(@create_attrs)
    cohort
  end

  describe "index" do
    test "lists all cohorts", %{conn: conn} do
      conn = get conn, cohort_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Cohorts"
    end
  end

  describe "new cohort" do
    test "renders form", %{conn: conn} do
      conn = get conn, cohort_path(conn, :new)
      assert html_response(conn, 200) =~ "New Cohort"
    end
  end

  describe "create cohort" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, cohort_path(conn, :create), cohort: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == cohort_path(conn, :show, id)

      conn = get conn, cohort_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Cohort"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, cohort_path(conn, :create), cohort: @invalid_attrs
      assert html_response(conn, 200) =~ "New Cohort"
    end
  end

  describe "edit cohort" do
    setup [:create_cohort]

    test "renders form for editing chosen cohort", %{conn: conn, cohort: cohort} do
      conn = get conn, cohort_path(conn, :edit, cohort)
      assert html_response(conn, 200) =~ "Edit Cohort"
    end
  end

  describe "update cohort" do
    setup [:create_cohort]

    test "redirects when data is valid", %{conn: conn, cohort: cohort} do
      conn = put conn, cohort_path(conn, :update, cohort), cohort: @update_attrs
      assert redirected_to(conn) == cohort_path(conn, :show, cohort)

      conn = get conn, cohort_path(conn, :show, cohort)
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, cohort: cohort} do
      conn = put conn, cohort_path(conn, :update, cohort), cohort: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Cohort"
    end
  end

  describe "delete cohort" do
    setup [:create_cohort]

    test "deletes chosen cohort", %{conn: conn, cohort: cohort} do
      conn = delete conn, cohort_path(conn, :delete, cohort)
      assert redirected_to(conn) == cohort_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, cohort_path(conn, :show, cohort)
      end
    end
  end

  defp create_cohort(_) do
    cohort = fixture(:cohort)
    {:ok, cohort: cohort}
  end
end

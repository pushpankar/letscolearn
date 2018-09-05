defmodule LetsColearnWeb.MilestoneControllerTest do
  use LetsColearnWeb.ConnCase

  alias LetsColearn.Aim

  @create_attrs %{milestone: "some milestone"}
  @update_attrs %{milestone: "some updated milestone"}
  @invalid_attrs %{milestone: nil}

  def fixture(:milestone) do
    {:ok, milestone} = Aim.create_milestone(@create_attrs)
    milestone
  end

  describe "index" do
    test "lists all milestones", %{conn: conn} do
      conn = get conn, milestone_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Milestones"
    end
  end

  describe "new milestone" do
    test "renders form", %{conn: conn} do
      conn = get conn, milestone_path(conn, :new)
      assert html_response(conn, 200) =~ "New Milestone"
    end
  end

  describe "create milestone" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, milestone_path(conn, :create), milestone: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == milestone_path(conn, :show, id)

      conn = get conn, milestone_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Milestone"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, milestone_path(conn, :create), milestone: @invalid_attrs
      assert html_response(conn, 200) =~ "New Milestone"
    end
  end

  describe "edit milestone" do
    setup [:create_milestone]

    test "renders form for editing chosen milestone", %{conn: conn, milestone: milestone} do
      conn = get conn, milestone_path(conn, :edit, milestone)
      assert html_response(conn, 200) =~ "Edit Milestone"
    end
  end

  describe "update milestone" do
    setup [:create_milestone]

    test "redirects when data is valid", %{conn: conn, milestone: milestone} do
      conn = put conn, milestone_path(conn, :update, milestone), milestone: @update_attrs
      assert redirected_to(conn) == milestone_path(conn, :show, milestone)

      conn = get conn, milestone_path(conn, :show, milestone)
      assert html_response(conn, 200) =~ "some updated milestone"
    end

    test "renders errors when data is invalid", %{conn: conn, milestone: milestone} do
      conn = put conn, milestone_path(conn, :update, milestone), milestone: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Milestone"
    end
  end

  describe "delete milestone" do
    setup [:create_milestone]

    test "deletes chosen milestone", %{conn: conn, milestone: milestone} do
      conn = delete conn, milestone_path(conn, :delete, milestone)
      assert redirected_to(conn) == milestone_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, milestone_path(conn, :show, milestone)
      end
    end
  end

  defp create_milestone(_) do
    milestone = fixture(:milestone)
    {:ok, milestone: milestone}
  end
end

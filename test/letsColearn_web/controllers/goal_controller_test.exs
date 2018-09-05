defmodule LetsColearnWeb.GoalControllerTest do
  use LetsColearnWeb.ConnCase

  alias LetsColearn.Aim

  @create_attrs %{end_date: ~N[2010-04-17 14:00:00.000000], goal: "some goal", pre_requisites: "some pre_requisites", start_date: ~N[2010-04-17 14:00:00.000000]}
  @update_attrs %{end_date: ~N[2011-05-18 15:01:01.000000], goal: "some updated goal", pre_requisites: "some updated pre_requisites", start_date: ~N[2011-05-18 15:01:01.000000]}
  @invalid_attrs %{end_date: nil, goal: nil, pre_requisites: nil, start_date: nil}

  def fixture(:goal) do
    {:ok, goal} = Aim.create_goal(@create_attrs)
    goal
  end

  describe "index" do
    test "lists all goals", %{conn: conn} do
      conn = get conn, goal_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Goals"
    end
  end

  describe "new goal" do
    test "renders form", %{conn: conn} do
      conn = get conn, goal_path(conn, :new)
      assert html_response(conn, 200) =~ "New Goal"
    end
  end

  describe "create goal" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, goal_path(conn, :create), goal: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == goal_path(conn, :show, id)

      conn = get conn, goal_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Goal"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, goal_path(conn, :create), goal: @invalid_attrs
      assert html_response(conn, 200) =~ "New Goal"
    end
  end

  describe "edit goal" do
    setup [:create_goal]

    test "renders form for editing chosen goal", %{conn: conn, goal: goal} do
      conn = get conn, goal_path(conn, :edit, goal)
      assert html_response(conn, 200) =~ "Edit Goal"
    end
  end

  describe "update goal" do
    setup [:create_goal]

    test "redirects when data is valid", %{conn: conn, goal: goal} do
      conn = put conn, goal_path(conn, :update, goal), goal: @update_attrs
      assert redirected_to(conn) == goal_path(conn, :show, goal)

      conn = get conn, goal_path(conn, :show, goal)
      assert html_response(conn, 200) =~ "some updated goal"
    end

    test "renders errors when data is invalid", %{conn: conn, goal: goal} do
      conn = put conn, goal_path(conn, :update, goal), goal: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Goal"
    end
  end

  describe "delete goal" do
    setup [:create_goal]

    test "deletes chosen goal", %{conn: conn, goal: goal} do
      conn = delete conn, goal_path(conn, :delete, goal)
      assert redirected_to(conn) == goal_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, goal_path(conn, :show, goal)
      end
    end
  end

  defp create_goal(_) do
    goal = fixture(:goal)
    {:ok, goal: goal}
  end
end

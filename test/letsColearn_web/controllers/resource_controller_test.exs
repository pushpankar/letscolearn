defmodule LetsColearnWeb.ResourceControllerTest do
  use LetsColearnWeb.ConnCase

  alias LetsColearn.Aim

  @create_attrs %{resource: "some resource"}
  @update_attrs %{resource: "some updated resource"}
  @invalid_attrs %{resource: nil}

  def fixture(:resource) do
    {:ok, resource} = Aim.create_resource(@create_attrs)
    resource
  end

  describe "index" do
    test "lists all resources", %{conn: conn} do
      conn = get conn, resource_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Resources"
    end
  end

  describe "new resource" do
    test "renders form", %{conn: conn} do
      conn = get conn, resource_path(conn, :new)
      assert html_response(conn, 200) =~ "New Resource"
    end
  end

  describe "create resource" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, resource_path(conn, :create), resource: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == resource_path(conn, :show, id)

      conn = get conn, resource_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Resource"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, resource_path(conn, :create), resource: @invalid_attrs
      assert html_response(conn, 200) =~ "New Resource"
    end
  end

  describe "edit resource" do
    setup [:create_resource]

    test "renders form for editing chosen resource", %{conn: conn, resource: resource} do
      conn = get conn, resource_path(conn, :edit, resource)
      assert html_response(conn, 200) =~ "Edit Resource"
    end
  end

  describe "update resource" do
    setup [:create_resource]

    test "redirects when data is valid", %{conn: conn, resource: resource} do
      conn = put conn, resource_path(conn, :update, resource), resource: @update_attrs
      assert redirected_to(conn) == resource_path(conn, :show, resource)

      conn = get conn, resource_path(conn, :show, resource)
      assert html_response(conn, 200) =~ "some updated resource"
    end

    test "renders errors when data is invalid", %{conn: conn, resource: resource} do
      conn = put conn, resource_path(conn, :update, resource), resource: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Resource"
    end
  end

  describe "delete resource" do
    setup [:create_resource]

    test "deletes chosen resource", %{conn: conn, resource: resource} do
      conn = delete conn, resource_path(conn, :delete, resource)
      assert redirected_to(conn) == resource_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, resource_path(conn, :show, resource)
      end
    end
  end

  defp create_resource(_) do
    resource = fixture(:resource)
    {:ok, resource: resource}
  end
end

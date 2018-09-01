defmodule LetsColearn.AimTest do
  use LetsColearn.DataCase

  alias LetsColearn.Aim

  describe "goals" do
    alias LetsColearn.Aim.Goal

    @valid_attrs %{end_date: ~N[2010-04-17 14:00:00.000000], goal: "some goal", pre_requisites: "some pre_requisites", start_date: ~N[2010-04-17 14:00:00.000000]}
    @update_attrs %{end_date: ~N[2011-05-18 15:01:01.000000], goal: "some updated goal", pre_requisites: "some updated pre_requisites", start_date: ~N[2011-05-18 15:01:01.000000]}
    @invalid_attrs %{end_date: nil, goal: nil, pre_requisites: nil, start_date: nil}

    def goal_fixture(attrs \\ %{}) do
      {:ok, goal} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Aim.create_goal()

      goal
    end

    test "list_goals/0 returns all goals" do
      goal = goal_fixture()
      assert Aim.list_goals() == [goal]
    end

    test "get_goal!/1 returns the goal with given id" do
      goal = goal_fixture()
      assert Aim.get_goal!(goal.id) == goal
    end

    test "create_goal/1 with valid data creates a goal" do
      assert {:ok, %Goal{} = goal} = Aim.create_goal(@valid_attrs)
      assert goal.end_date == ~N[2010-04-17 14:00:00.000000]
      assert goal.goal == "some goal"
      assert goal.pre_requisites == "some pre_requisites"
      assert goal.start_date == ~N[2010-04-17 14:00:00.000000]
    end

    test "create_goal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Aim.create_goal(@invalid_attrs)
    end

    test "update_goal/2 with valid data updates the goal" do
      goal = goal_fixture()
      assert {:ok, goal} = Aim.update_goal(goal, @update_attrs)
      assert %Goal{} = goal
      assert goal.end_date == ~N[2011-05-18 15:01:01.000000]
      assert goal.goal == "some updated goal"
      assert goal.pre_requisites == "some updated pre_requisites"
      assert goal.start_date == ~N[2011-05-18 15:01:01.000000]
    end

    test "update_goal/2 with invalid data returns error changeset" do
      goal = goal_fixture()
      assert {:error, %Ecto.Changeset{}} = Aim.update_goal(goal, @invalid_attrs)
      assert goal == Aim.get_goal!(goal.id)
    end

    test "delete_goal/1 deletes the goal" do
      goal = goal_fixture()
      assert {:ok, %Goal{}} = Aim.delete_goal(goal)
      assert_raise Ecto.NoResultsError, fn -> Aim.get_goal!(goal.id) end
    end

    test "change_goal/1 returns a goal changeset" do
      goal = goal_fixture()
      assert %Ecto.Changeset{} = Aim.change_goal(goal)
    end
  end

  describe "milestones" do
    alias LetsColearn.Aim.Milestone

    @valid_attrs %{milestone: "some milestone"}
    @update_attrs %{milestone: "some updated milestone"}
    @invalid_attrs %{milestone: nil}

    def milestone_fixture(attrs \\ %{}) do
      {:ok, milestone} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Aim.create_milestone()

      milestone
    end

    test "list_milestones/0 returns all milestones" do
      milestone = milestone_fixture()
      assert Aim.list_milestones() == [milestone]
    end

    test "get_milestone!/1 returns the milestone with given id" do
      milestone = milestone_fixture()
      assert Aim.get_milestone!(milestone.id) == milestone
    end

    test "create_milestone/1 with valid data creates a milestone" do
      assert {:ok, %Milestone{} = milestone} = Aim.create_milestone(@valid_attrs)
      assert milestone.milestone == "some milestone"
    end

    test "create_milestone/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Aim.create_milestone(@invalid_attrs)
    end

    test "update_milestone/2 with valid data updates the milestone" do
      milestone = milestone_fixture()
      assert {:ok, milestone} = Aim.update_milestone(milestone, @update_attrs)
      assert %Milestone{} = milestone
      assert milestone.milestone == "some updated milestone"
    end

    test "update_milestone/2 with invalid data returns error changeset" do
      milestone = milestone_fixture()
      assert {:error, %Ecto.Changeset{}} = Aim.update_milestone(milestone, @invalid_attrs)
      assert milestone == Aim.get_milestone!(milestone.id)
    end

    test "delete_milestone/1 deletes the milestone" do
      milestone = milestone_fixture()
      assert {:ok, %Milestone{}} = Aim.delete_milestone(milestone)
      assert_raise Ecto.NoResultsError, fn -> Aim.get_milestone!(milestone.id) end
    end

    test "change_milestone/1 returns a milestone changeset" do
      milestone = milestone_fixture()
      assert %Ecto.Changeset{} = Aim.change_milestone(milestone)
    end
  end

  describe "resources" do
    alias LetsColearn.Aim.Resource

    @valid_attrs %{resource: "some resource"}
    @update_attrs %{resource: "some updated resource"}
    @invalid_attrs %{resource: nil}

    def resource_fixture(attrs \\ %{}) do
      {:ok, resource} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Aim.create_resource()

      resource
    end

    test "list_resources/0 returns all resources" do
      resource = resource_fixture()
      assert Aim.list_resources() == [resource]
    end

    test "get_resource!/1 returns the resource with given id" do
      resource = resource_fixture()
      assert Aim.get_resource!(resource.id) == resource
    end

    test "create_resource/1 with valid data creates a resource" do
      assert {:ok, %Resource{} = resource} = Aim.create_resource(@valid_attrs)
      assert resource.resource == "some resource"
    end

    test "create_resource/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Aim.create_resource(@invalid_attrs)
    end

    test "update_resource/2 with valid data updates the resource" do
      resource = resource_fixture()
      assert {:ok, resource} = Aim.update_resource(resource, @update_attrs)
      assert %Resource{} = resource
      assert resource.resource == "some updated resource"
    end

    test "update_resource/2 with invalid data returns error changeset" do
      resource = resource_fixture()
      assert {:error, %Ecto.Changeset{}} = Aim.update_resource(resource, @invalid_attrs)
      assert resource == Aim.get_resource!(resource.id)
    end

    test "delete_resource/1 deletes the resource" do
      resource = resource_fixture()
      assert {:ok, %Resource{}} = Aim.delete_resource(resource)
      assert_raise Ecto.NoResultsError, fn -> Aim.get_resource!(resource.id) end
    end

    test "change_resource/1 returns a resource changeset" do
      resource = resource_fixture()
      assert %Ecto.Changeset{} = Aim.change_resource(resource)
    end
  end

  describe "comments" do
    alias LetsColearn.Aim.Comment

    @valid_attrs %{comment: "some comment"}
    @update_attrs %{comment: "some updated comment"}
    @invalid_attrs %{comment: nil}

    def comment_fixture(attrs \\ %{}) do
      {:ok, comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Aim.create_comment()

      comment
    end

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Aim.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Aim.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      assert {:ok, %Comment{} = comment} = Aim.create_comment(@valid_attrs)
      assert comment.comment == "some comment"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Aim.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      assert {:ok, comment} = Aim.update_comment(comment, @update_attrs)
      assert %Comment{} = comment
      assert comment.comment == "some updated comment"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Aim.update_comment(comment, @invalid_attrs)
      assert comment == Aim.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Aim.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Aim.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Aim.change_comment(comment)
    end
  end
end

defmodule LetsColearn.CohortsTest do
  use LetsColearn.DataCase

  alias LetsColearn.Cohorts

  describe "cohorts" do
    alias LetsColearn.Cohorts.Cohort

    @valid_attrs %{description: "some description", title: "some title"}
    @update_attrs %{description: "some updated description", title: "some updated title"}
    @invalid_attrs %{description: nil, title: nil}

    def cohort_fixture(attrs \\ %{}) do
      {:ok, cohort} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cohorts.create_cohort()

      cohort
    end

    test "list_cohorts/0 returns all cohorts" do
      cohort = cohort_fixture()
      assert Cohorts.list_cohorts() == [cohort]
    end

    test "get_cohort!/1 returns the cohort with given id" do
      cohort = cohort_fixture()
      assert Cohorts.get_cohort!(cohort.id) == cohort
    end

    test "create_cohort/1 with valid data creates a cohort" do
      assert {:ok, %Cohort{} = cohort} = Cohorts.create_cohort(@valid_attrs)
      assert cohort.description == "some description"
      assert cohort.title == "some title"
    end

    test "create_cohort/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cohorts.create_cohort(@invalid_attrs)
    end

    test "update_cohort/2 with valid data updates the cohort" do
      cohort = cohort_fixture()
      assert {:ok, cohort} = Cohorts.update_cohort(cohort, @update_attrs)
      assert %Cohort{} = cohort
      assert cohort.description == "some updated description"
      assert cohort.title == "some updated title"
    end

    test "update_cohort/2 with invalid data returns error changeset" do
      cohort = cohort_fixture()
      assert {:error, %Ecto.Changeset{}} = Cohorts.update_cohort(cohort, @invalid_attrs)
      assert cohort == Cohorts.get_cohort!(cohort.id)
    end

    test "delete_cohort/1 deletes the cohort" do
      cohort = cohort_fixture()
      assert {:ok, %Cohort{}} = Cohorts.delete_cohort(cohort)
      assert_raise Ecto.NoResultsError, fn -> Cohorts.get_cohort!(cohort.id) end
    end

    test "change_cohort/1 returns a cohort changeset" do
      cohort = cohort_fixture()
      assert %Ecto.Changeset{} = Cohorts.change_cohort(cohort)
    end
  end

  describe "chats" do
    alias LetsColearn.Cohorts.Chat

    @valid_attrs %{message: "some message"}
    @update_attrs %{message: "some updated message"}
    @invalid_attrs %{message: nil}

    def chat_fixture(attrs \\ %{}) do
      {:ok, chat} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cohorts.create_chat()

      chat
    end

    test "list_chats/0 returns all chats" do
      chat = chat_fixture()
      assert Cohorts.list_chats() == [chat]
    end

    test "get_chat!/1 returns the chat with given id" do
      chat = chat_fixture()
      assert Cohorts.get_chat!(chat.id) == chat
    end

    test "create_chat/1 with valid data creates a chat" do
      assert {:ok, %Chat{} = chat} = Cohorts.create_chat(@valid_attrs)
      assert chat.message == "some message"
    end

    test "create_chat/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cohorts.create_chat(@invalid_attrs)
    end

    test "update_chat/2 with valid data updates the chat" do
      chat = chat_fixture()
      assert {:ok, chat} = Cohorts.update_chat(chat, @update_attrs)
      assert %Chat{} = chat
      assert chat.message == "some updated message"
    end

    test "update_chat/2 with invalid data returns error changeset" do
      chat = chat_fixture()
      assert {:error, %Ecto.Changeset{}} = Cohorts.update_chat(chat, @invalid_attrs)
      assert chat == Cohorts.get_chat!(chat.id)
    end

    test "delete_chat/1 deletes the chat" do
      chat = chat_fixture()
      assert {:ok, %Chat{}} = Cohorts.delete_chat(chat)
      assert_raise Ecto.NoResultsError, fn -> Cohorts.get_chat!(chat.id) end
    end

    test "change_chat/1 returns a chat changeset" do
      chat = chat_fixture()
      assert %Ecto.Changeset{} = Cohorts.change_chat(chat)
    end
  end
end

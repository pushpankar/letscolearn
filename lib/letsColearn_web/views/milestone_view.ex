defmodule LetsColearnWeb.MilestoneView do
  use LetsColearnWeb, :view

  alias LetsColearn.Accounts.Auth
  alias LetsColearn.Aim

  def comment_count(milestone) do
    count = Aim.comment_count(milestone)
    if count > 1 do
      to_string(count) <> " comments"
    else
      to_string(count) <> " comment"
    end
  end
  
  def resource_count(milestone) do
    count = Aim.resource_count(milestone)
    if count > 1 do
      to_string(count) <> " resources"
    else
      to_string(count)<> " resource"
    end
  end
end

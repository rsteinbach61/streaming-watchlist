module ApplicationHelper

# display error message
  def error_helper(object)
      content_tag(:h2, "Oops:", id: "error_explanation")

  end
#create a list of errors for the object being created
  def error_list(object)
      content_tag(:ul, :class => "error msgs") do
        object.errors.full_messages.each do |msg|
        concat content_tag(:li, msg)
    # build a create watchlist link if no watchlist is selected
        if msg == "Watchlist can't be blank"
          concat link_to "Create a Watchlist", new_watchlist_path
        end
        end

      end

  end
end

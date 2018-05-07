module ApplicationHelper

  def error_helper(object)
      content_tag(:h2, "Oops:", id: "error_explanation")

  end

  def error_list(object)
      content_tag(:ul, :class => "error msgs") do
        object.errors.full_messages.each do |msg|
        concat content_tag(:li, msg)
        end
      end

  end
end

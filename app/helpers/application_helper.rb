module ApplicationHelper

  def error_helper(object)

      content_tag(:div, content_tag(:h2, "Failed"), id: "error_explanation")

      content_tag(:ul, :class => "error msgs") do
        object.errors.full_messages.each do |msg|
        concat content_tag(:li, msg)
        end
      end
  end
end

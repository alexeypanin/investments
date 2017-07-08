module ApplicationHelper
  def error_message_for object, field
    field = field.to_sym
    if object.errors.include?(field)
      content_tag :span, object.errors[field].to_sentence, class: "help-block m-b-none", style: 'color:red;'
    end
  end
end

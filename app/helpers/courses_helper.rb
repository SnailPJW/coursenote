module CoursesHelper
  def category_button(name)
    uri = params[:by_category]
    if !uri.nil? && uri.include?(name)
      active = true
    end
    display_name = name.length == 1 ? "#{name}學" : name

    html = <<-HTML
      <label class="btn btn-warning mg-b-10 #{'active' if active}">
      <input type="checkbox" name="by_category[]" value="#{name}" #{'checked' if active}>
      #{display_name}
      </label>
    HTML

    html.html_safe
  end

  def avatar_path(comment)
    if is_author?(comment)
      'user-indicator.png'
    else
      "https://secure.gravatar.com/avatar/#{comment.avatar}?d=identicon&s=40"
    end
  end

  def page_to_title(page)
    "第#{page}頁"
  end

  def course_status(state)
    state ? '是' : '否'
  end

  def is_author?(obj)
    user_signed_in? && obj.user_id == current_user.id
  end
end

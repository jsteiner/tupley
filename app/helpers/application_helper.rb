module ApplicationHelper
  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
      hard_wrap: true, filter_html: true, autolink: true,
      no_intraemphasis: true, fenced_code: true, gh_blockcode: true
    )

    if text.present?
      markdown.render(text).html_safe
    end
  end
end

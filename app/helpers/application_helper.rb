module ApplicationHelper

  def full_title page_title = ""
    page_title.present? ? "#{page_title} - #{t("base_title")}" : t("base_title")
  end
end

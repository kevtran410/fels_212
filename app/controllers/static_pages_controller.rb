class StaticPagesController < ApplicationController

  def show
    if valid_page_name?
      render template: "static_pages/#{params[:page_name]}"
    else
      render file: "public/404.html"
    end
  end

  private
  def valid_page_name?
    File.exist? Pathname.new(
      Rails.root + "app/views/static_pages/#{params[:page_name]}.html.erb")
  end
end

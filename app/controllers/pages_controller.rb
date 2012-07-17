class PagesController < ApplicationController

  def home
    @title = "Home | CareContent"
  end

  def about
    @title = "About | CareContent"
  end

  def suggestions
    SuggestionsMailer.suggestion_email(params[:email], params[:suggestion]).deliver
    flash[:success] = "Your message has been sent. Thanks for your feedback!"
    redirect_to content_files_url
  end

  def contact
    SuggestionsMailer.contact_email(params).deliver
    flash[:success] = "Your message has been sent. Thanks for your feedback!"
    redirect_to root_url
  end

end

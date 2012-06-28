class SuggestionsMailer < ActionMailer::Base
  default from: "suggestions@carecontent.com"

  def suggestion_email(email, suggestion)
    @email = email
    @suggestion = suggestion
    mail(:to => "kadesha@carecontent.com", :subject => "New CareContent Suggestion")
  end

  def contact_email(form_data)
    @form_data = form_data
    mail(:to => "kadesha@carecontent.com", :subject => "New CareContent Suggestion")
  end
end

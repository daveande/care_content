class SuggestionsMailer < ActionMailer::Base
  default from: "kadesha@carecontent.com"

  def suggestion_email(email, suggestion)
    @email = email
    @suggestion = suggestion
    mail(:to => "kadesha@carecontent.com", :subject => "New CareContent Suggestion")
  end

  def contact_email(form_data)
    @form_data = form_data
    mail(:to => "kadesha@carecontent.com", :subject => "New CareContent Suggestion")
  end

  def send_sample(name, email, organization)
    @name = name
    @email = email
    @organization = organization
    mail(:to => "kadesha@carecontent.com", :subject => "Send a CareContent Sample")
  end

  def confirmed_purchase_email(purchase)
    @purchase = purchase
    mail(:to => "kadesha@carecontent.com", :subject => "Confirmed Purchase")
  end

  def send_unconfirmed_purchase(plan, email, name, organization_name, organization_zipcode)
    @plan = plan
    @email = email
    @name = name
    @organization_name = organization_name
    @organization_zipcode = organization_zipcode
    mail(:to => "kadesha@carecontent.com", :subject => "Unconfirmed Purchase")
  end
end

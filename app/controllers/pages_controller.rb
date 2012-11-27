class PagesController < ApplicationController

  def home
    @title = "Home | CareContent"
  end

  def about
    @title = "About | CareContent"
  end

  def terms
    @title = "Terms and Conditions | CareContent"
  end

  def unconfirmed_purchase
    if params[:plan_id].nil?
      flash[:alert] = "Please select a plan before purchasing" 
      redirect_to plans_url
    else
      @plan = Plan.find(params[:plan_id])
      @name = params
    end
  end

  def submit_unconfirmed_purchase
    if params[:email].empty? || params[:primary_contact_name].empty? || params[:organization_name].empty? || params[:organization_zipcode].empty?
      flash[:alert] = "Please enter all account information"
      redirect_to unconfirmed_purchase_url(:plan_id => params[:plan_id])
    elsif params[:agreed_to_terms].nil?
      flash[:alert] = "Please agree to terms to submit"
      redirect_to unconfirmed_purchase_url(:plan_id => params[:plan_id])
    else
      @plan = Plan.find(params[:plan_id])
      SuggestionsMailer.send_unconfirmed_purchase(@plan, params[:email], params[:primary_contact_name], params[:organization_name], params[:organization_zipcode]).deliver
      flash[:success] = "Your information has been submitted. We will set up your account and contact you shortly."
      redirect_to root_url
    end
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

  def send_sample
    SuggestionsMailer.send_sample(params[:name], params[:email], params[:organization]).deliver
    flash[:success] = "Your message has been sent. We'll contact you shortly with a sample!"
    redirect_to :back

  end

end

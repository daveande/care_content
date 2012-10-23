class Purchase < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan
  validates_presence_of :user, :plan, :agreed_to_terms
  validate :not_a_downgrade
  after_create :expire_monthly_plans
  attr_accessible :user_id, :plan_id, :period_end, :expired, :agreed_to_terms

  def not_a_downgrade
    purchases = self.user.valid_purchases
    purchases.each do |p|
      if p.plan.downloads_per == 'month' && self.plan.max_downloads < p.plan.max_downloads
        errors.add(:purchase, "cannot downgrade subscription. Please contact us with questions.")
      end
    end
  end

  def expire_monthly_plans
    purchases = self.user.valid_purchases
    purchases.each do |p|
      if p.plan.downloads_per == 'month' && p.id != self.id
        p.update_attribute(:expired, true)
      end
    end
  end

  def current_expire
    if self.plan.downloads_per == 'year'
      [self.created_at, self.period_end]
    else
      dates_array = []
      (0..12).each {|i| dates_array << self.created_at + i.months}
      
      months_since_purchase = ((Time.now() - self.created_at)/2628288).ceil
      max = dates_array[months_since_purchase]
      min = dates_array[months_since_purchase - 1]
      [min, max]
    end
  end
end

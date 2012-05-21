class User < ActiveRecord::Base
	has_many :own_invoices, :class_name => "Invoice", :foreign_key => 'creator_id'
	has_many :duties
	has_many :invoices, :through => :duties

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"].split(" ").first
    end
  end

  def standing
    minus = invoices.reduce(0) do |sum, val|
      sum - val.individual_sum
    end
    own_invoices.reduce(minus) do |sum, val|
      sum + val.price
    end
  end

  def mentioned_invoices
    own = own_invoices.order('date DESC').limit(10)
    other = invoices.order('date DESC').limit(10)
    ( ((own-other) + other).sort { |a,b| b.created_at <=> a.created_at } )[0..10]
  end
end

class User < ActiveRecord::Base
has_many :own_invoices, :class_name => "Invoice", :foreign_key => 'creator_id'
has_many :duties
has_many :invoices, :through => :duties

end

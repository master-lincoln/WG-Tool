class AddWantsMailToUser < ActiveRecord::Migration
  def change
    add_column :users, :wants_mail, :boolean
    User.all.each do |user|
    	user.update_attributes! :wants_mail => false
    end
  end
end

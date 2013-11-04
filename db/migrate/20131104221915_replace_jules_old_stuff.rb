class ReplaceJulesOldStuff < ActiveRecord::Migration
  
  def up
  	jule_old = 8
  	jule_new = 9
  	Duty.update_all({:user_id => jule_new}, {:user_id => jule_old})
  	Invoice.update_all({:creator_id => jule_new}, {:creator_id => jule_old})
  	User.find(jule_old).destroy
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end

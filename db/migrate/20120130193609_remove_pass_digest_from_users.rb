class RemovePassDigestFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :pass_digest
  end

  def down
    add_column :users, :pass_digest, :string
  end
end

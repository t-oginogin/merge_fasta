class AddUserIdToFastaDatum < ActiveRecord::Migration
  def change
    add_column :fasta_data, :user_id, :integer
    add_index :fasta_data, :user_id, unique: false
  end
end

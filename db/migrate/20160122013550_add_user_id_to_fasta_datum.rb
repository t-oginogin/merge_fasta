class AddUserIdToFastaDatum < ActiveRecord::Migration[5.1]
  def change
    add_column :fasta_data, :user_id, :integer
    add_index :fasta_data, :user_id, unique: false
  end
end

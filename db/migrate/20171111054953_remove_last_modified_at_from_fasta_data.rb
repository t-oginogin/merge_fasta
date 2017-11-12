class RemoveLastModifiedAtFromFastaData < ActiveRecord::Migration[5.1]
  def change
    remove_column :fasta_data, :last_modified_at
  end
end

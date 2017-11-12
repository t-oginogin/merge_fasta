class AddLastModifiedAtToFastaData < ActiveRecord::Migration[5.1]
  def change
    add_column :fasta_data, :last_modified_at, :datetime
  end
end

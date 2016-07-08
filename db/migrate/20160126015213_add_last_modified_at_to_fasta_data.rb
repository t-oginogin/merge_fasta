class AddLastModifiedAtToFastaData < ActiveRecord::Migration[4.2]
  def change
    add_column :fasta_data, :last_modified_at, :datetime
  end
end

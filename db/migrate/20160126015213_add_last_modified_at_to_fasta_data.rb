class AddLastModifiedAtToFastaData < ActiveRecord::Migration
  def change
    add_column :fasta_data, :last_modified_at, :datetime
  end
end

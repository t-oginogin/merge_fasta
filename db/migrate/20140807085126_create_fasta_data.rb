class CreateFastaData < ActiveRecord::Migration
  def change
    create_table :fasta_data do |t|
      t.string :filename
      t.binary :data

      t.timestamps
    end
  end
end

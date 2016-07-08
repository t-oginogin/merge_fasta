class CreateFastaData < ActiveRecord::Migration[4.2]
  def change
    create_table :fasta_data do |t|
      t.string :filename
      t.binary :data

      t.timestamps null: false
    end
  end
end

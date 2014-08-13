class FastaDatum < ActiveRecord::Base
  def self.merged_content( targets )
    fasta_data = FastaDatum.find targets
    content = ""
    fasta_data.each do |fasta_datum|
      content = "#{content}\n\>#{File.basename fasta_datum.filename, '.*'}\n#{fasta_datum.data}\n"
    end
    content
  end
end

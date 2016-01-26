class FastaDatum < ActiveRecord::Base
  belongs_to :user

  def self.merged_content( fasta_data )
    content = ""
    fasta_data.each do |fasta_datum|
      content = "#{content}\n#{fasta_datum.content}\n"
    end
    content
  end

  def content
    if data =~ /\>/
      data
    else
      "\>#{File.basename filename, '.*'}\n#{data}"
    end
  end
end

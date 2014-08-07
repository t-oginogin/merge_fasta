json.array!(@fasta_data) do |fasta_datum|
  json.extract! fasta_datum, :id, :filename, :data
  json.url fasta_datum_url(fasta_datum, format: :json)
end

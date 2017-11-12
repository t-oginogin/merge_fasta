FactoryBot.define do
  factory :fasta_datum do
    user_id 1
    filename 'test.fasta'
    data "ABCDEFG1\nBCDEFGH1"
  end
end

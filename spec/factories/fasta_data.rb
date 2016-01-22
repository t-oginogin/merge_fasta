FactoryGirl.define do
  factory :fasta_datum do
    filename 'test.fasta'
    data "ABCDEFG1\nBCDEFGH1"
  end
end

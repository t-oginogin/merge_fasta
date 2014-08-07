require 'rails_helper'

RSpec.describe "FastaData", :type => :request do
  describe "GET /fasta_data" do
    it "works! (now write some real specs)" do
      get fasta_data_path
      expect(response.status).to be(200)
    end
  end
end

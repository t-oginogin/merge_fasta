require "rails_helper"

RSpec.describe FastaDataController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/fasta_data").to route_to("fasta_data#index")
    end

    it "routes to #new" do
      expect(:get => "/fasta_data/new").to route_to("fasta_data#new")
    end

    it "routes to #show" do
      expect(:get => "/fasta_data/1").to route_to("fasta_data#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/fasta_data/1/edit").to route_to("fasta_data#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/fasta_data").to route_to("fasta_data#create")
    end

    it "routes to #update" do
      expect(:put => "/fasta_data/1").to route_to("fasta_data#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/fasta_data/1").to route_to("fasta_data#destroy", :id => "1")
    end

  end
end

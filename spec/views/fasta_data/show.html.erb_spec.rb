require 'rails_helper'

RSpec.describe "fasta_data/show", :type => :view do
  before(:each) do
    @fasta_datum = assign(:fasta_datum, FastaDatum.create!(
      :filename => "Filename",
      :data => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Filename/)
    expect(rendered).to match(//)
  end
end

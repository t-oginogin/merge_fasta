require 'rails_helper'

RSpec.describe "fasta_data/show", :type => :view do
  let(:user1) { create(:user) }
  before(:each) do
    @fasta_datum = assign(:fasta_datum, FastaDatum.create!(user_id: user1.id, filename: 'Filename', data: ''))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Filename/)
    expect(rendered).to match(//)
  end
end

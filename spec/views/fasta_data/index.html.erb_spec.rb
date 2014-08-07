require 'rails_helper'

RSpec.describe "fasta_data/index", :type => :view do
  before(:each) do
    assign(:fasta_data, [
      FastaDatum.create!(
        :filename => "Filename",
        :data => ""
      ),
      FastaDatum.create!(
        :filename => "Filename",
        :data => ""
      )
    ])
  end

  it "renders a list of fasta_data" do
    render
    assert_select "tr>td", :text => "Filename".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end

require 'rails_helper'

RSpec.describe "fasta_data/edit", :type => :view do
  before(:each) do
    @fasta_datum = assign(:fasta_datum, FastaDatum.create!(
      :filename => "MyString",
      :data => ""
    ))
  end

  it "renders the edit fasta_datum form" do
    render

    assert_select "form[action=?][method=?]", fasta_datum_path(@fasta_datum), "post" do

      assert_select "input#fasta_datum_filename[name=?]", "fasta_datum[filename]"

      assert_select "input#fasta_datum_data[name=?]", "fasta_datum[data]"
    end
  end
end

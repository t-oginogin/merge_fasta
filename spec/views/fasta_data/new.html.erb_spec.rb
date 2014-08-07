require 'rails_helper'

RSpec.describe "fasta_data/new", :type => :view do
  before(:each) do
    assign(:fasta_datum, FastaDatum.new(
      :filename => "MyString",
      :data => ""
    ))
  end

  it "renders new fasta_datum form" do
    render

    assert_select "form[action=?][method=?]", fasta_data_path, "post" do

      assert_select "input#fasta_datum_filename[name=?]", "fasta_datum[filename]"

      assert_select "input#fasta_datum_data[name=?]", "fasta_datum[data]"
    end
  end
end

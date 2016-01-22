require 'rails_helper'

describe 'merge', :type => :feature do
  def create_fasta(filename, data)
    create(:fasta_datum, filename: filename, data: data)
  end

  let(:user) { create(:user) }
  let(:filename1) {'test1.fasta'}
  let(:filename2) {'test2.fasta'}
  let(:data1) {"ABCDEFG1\nBCDEFGH1"}
  let(:data2) {"ABCDEFG2\nBCDEFGH2"}

  before do
    login user
    create_fasta(filename1, "#{data1}")
    create_fasta(filename2, "#{data2}")
  end

  it 'merge 2 data', :js => true do
    visit '/fasta_data/'
    # page.save_screenshot('spec/results/merge_before.png' ,:full => true)
    click_button 'Merge Fasta'
    # page.save_screenshot('spec/results/merge_after.png' ,:full => true)
    expect(page).to have_content ">#{File.basename(filename1, '.*')}\n#{data1}"
    expect(page).to have_content ">#{File.basename(filename2, '.*')}\n#{data2}"
  end
end

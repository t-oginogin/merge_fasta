require 'rails_helper'

describe 'merge', :type => :feature do
  def create_fasta(user_id, filename, data)
    create(:fasta_datum, user_id: user_id, filename: filename, data: data)
  end

  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:filename1) {'test1.fasta'}
  let(:filename2) {'test2.fasta'}
  let(:filename3) {'test3.fasta'}
  let(:data1) {"ABCDEFG1\nBCDEFGH1"}
  let(:data2) {"ABCDEFG2\nBCDEFGH2"}
  let(:data3) {"ABCDEFG3\nBCDEFGH3"}

  before do
    login user1
    create_fasta(user1.id, filename1, "#{data1}")
    create_fasta(user1.id, filename2, "#{data2}")
    create_fasta(user2.id, filename3, "#{data3}")
  end

  it 'merge 2 data', :js => true do
    visit '/fasta_data/'
    # page.save_screenshot('spec/results/merge_before.png' ,:full => true)
    click_button 'Merge Fasta'
    # page.save_screenshot('spec/results/merge_after.png' ,:full => true)
    expect(page).to have_content ">#{File.basename(filename1, '.*')}\n#{data1}"
    expect(page).to have_content ">#{File.basename(filename2, '.*')}\n#{data2}"
    expect(page).not_to have_content ">#{File.basename(filename3, '.*')}\n#{data3}"
  end
end

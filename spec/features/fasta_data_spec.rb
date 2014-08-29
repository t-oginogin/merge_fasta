require 'rails_helper'

describe 'merge', :type => :feature do
  before do
      content1 = "ABCDEFG1\nBCDEFGH1"
      FastaDatum.create(id: 1, filename: 'test1.fasta', data: content1)

      content2 = "ABCDEFG2\nBCDEFGH2"
      FastaDatum.create(id: 2, filename: 'test2.fasta', data: content2)
  end

  it 'merge 2 data', :js => true do
    visit '/'
    page.save_screenshot('spec/results/merge_before.png' ,:full => true)
    click_button 'Merge Fasta'
    page.save_screenshot('spec/results/merge_after.png' ,:full => true)
    expect(page).to have_content '>test1'
    expect(page).to have_content '>test2'
  end
end

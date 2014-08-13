require 'rails_helper'

RSpec.describe FastaDatum, :type => :model do
  describe 'merged_content' do
    before do
      FastaDatum.destroy_all

      content1 = "ABCDEFG1\nBCDEFGH1"
      FastaDatum.create(id: 1, filename: 'test1.fasta', data: content1)

      content2 = "ABCDEFG2\nBCDEFGH2"
      FastaDatum.create(id: 2, filename: 'test2.fasta', data: content2)

      content3 = "ABCDEFG3\nBCDEFGH3"
      FastaDatum.create(id: 3, filename: 'test3.fasta', data: content3)
    end

    let(:expected_content1) {
      content = ""
      content = "#{content}\n>test1\nABCDEFG1\nBCDEFGH1\n"
      content = "#{content}\n>test2\nABCDEFG2\nBCDEFGH2\n"
      content = "#{content}\n>test3\nABCDEFG3\nBCDEFGH3\n"
    }

    let(:expected_content2) {
      content = ""
      content = "#{content}\n>test1\nABCDEFG1\nBCDEFGH1\n"
      content = "#{content}\n>test3\nABCDEFG3\nBCDEFGH3\n"
    }

    let(:expected_content3) {
      content = ""
      content = "#{content}\n>test2\nABCDEFG2\nBCDEFGH2\n"
    }

    context 'when selected all files' do
      it 'includes each filename and content of all files' do
        content = FastaDatum.merged_content [1,2,3]
        expect(content.gsub(' ', '')).to eq expected_content1.gsub(' ', '')
      end
    end

    context 'when selected files where id=1,3' do
      it 'includes each filename and content of files where id=1,3' do
        content = FastaDatum.merged_content [1,3]
        expect(content.gsub(' ', '')).to eq expected_content2.gsub(' ', '')
      end
    end

    context 'when selected file where id=2' do
      it 'includes filename and content of file where id=2' do
        content = FastaDatum.merged_content [2]
        expect(content.gsub(' ', '')).to eq expected_content3.gsub(' ', '')
      end
    end

    context 'when selected no files' do
      it 'is empty string' do
        content = FastaDatum.merged_content []
        expect(content).to eq ''
      end
    end
  end
end

require 'rails_helper'

RSpec.describe FastaDatum, :type => :model do
  describe 'merged_content' do
    let!(:fasta_data) {
      fasta_data = []
      content1 = "ABCDEFG1\nBCDEFGH1"
      fasta_data << FastaDatum.create(id: 1, filename: 'test1.fasta', data: content1)
      content2 = "ABCDEFG2\nBCDEFGH2"
      fasta_data << FastaDatum.create(id: 2, filename: 'test2.fasta', data: content2)
      content3 = "ABCDEFG3\nBCDEFGH3"
      fasta_data << FastaDatum.create(id: 3, filename: 'test3.fasta', data: content3)
      content4 = "\>test\nABCDEFG4\nBCDEFGH4"
      fasta_data << FastaDatum.create(id: 4, filename: 'test4.fasta', data: content4)
      fasta_data
    }

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

    let(:expected_content4) {
      content = ""
      content = "#{content}\n>test1\nABCDEFG1\nBCDEFGH1\n"
      content = "#{content}\n>test\nABCDEFG4\nBCDEFGH4\n"
    }

    context 'when selected all files' do
      it 'includes each filename and content of all files' do
        content = FastaDatum.merged_content [fasta_data[0], fasta_data[1], fasta_data[2]]
        expect(content.gsub(' ', '')).to eq expected_content1.gsub(' ', '')
      end
    end

    context 'when selected files where id=1,3' do
      it 'includes each filename and content of files where id=1,3' do
        content = FastaDatum.merged_content [fasta_data[0], fasta_data[2]]
        expect(content.gsub(' ', '')).to eq expected_content2.gsub(' ', '')
      end
    end

    context 'when selected file where id=2' do
      it 'includes filename and content of file where id=2' do
        content = FastaDatum.merged_content [fasta_data[1]]
        expect(content.gsub(' ', '')).to eq expected_content3.gsub(' ', '')
      end
    end

    context 'when selected no files' do
      it 'is empty string' do
        content = FastaDatum.merged_content []
        expect(content).to eq ''
      end
    end

    context 'when selected files include ">"' do
      it 'does not include filename of the file' do
        content = FastaDatum.merged_content [fasta_data[0], fasta_data[3]]
        expect(content.gsub(' ', '')).to eq expected_content4.gsub(' ', '')
      end
    end

  end

  describe 'content' do
    before do
      FastaDatum.destroy_all

      content_no_identifier = "ABCDEFG1\nBCDEFGH1"
      FastaDatum.create(id: 1, filename: 'test_no_identifier.fasta', data: content_no_identifier)

      content_with_identifier = "\>test\nABCDEFG2\nBCDEFGH2"
      FastaDatum.create(id: 2, filename: 'content_with_identifier.fasta', data: content_with_identifier)
    end

    let(:expected_content_no_identifier) {
      content = ">test_no_identifier\nABCDEFG1\nBCDEFGH1"
    }

    let(:expected_content_with_identifier) {
      content = ">test\nABCDEFG2\nBCDEFGH2"
    }

    context 'when selected file does not include ">"' do
      it 'include filename of the file' do
        fasta_datum = FastaDatum.find 1
        expect(fasta_datum.content.gsub(' ', '')).to eq expected_content_no_identifier.gsub(' ', '')
      end
    end

    context 'when selected file include ">"' do
      it 'does not include filename of the file' do
        fasta_datum = FastaDatum.find 2
        expect(fasta_datum.content.gsub(' ', '')).to eq expected_content_with_identifier.gsub(' ', '')
      end
    end
  end
end

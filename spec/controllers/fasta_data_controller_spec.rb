require 'rails_helper'

RSpec.describe FastaDataController, :type => :controller do
  let(:user) { create(:user) }

  describe 'GET index' do
    let!(:fasta_data) {
      fasta_data = []
      Timecop.freeze(Date.today) do
        fasta_data << create(:fasta_datum)
      end
      Timecop.freeze(Date.yesterday) do
        fasta_data << create(:fasta_datum)
      end
      fasta_data
    }

    context 'when user logged in' do
      before do
        sign_in user
      end

      it 'is ordered by created_at' do
        get :index
        expect(assigns(:fasta_data).map(&:id)).to eq([fasta_data[1].id, fasta_data[0].id])
      end
    end

    context 'when user did not log in' do
      it 'redirect to login page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET show' do
    let!(:fasta_datum) { create(:fasta_datum) }

    context 'when user logged in' do
      before do
        sign_in user
      end

      it 'assigns the requested fasta_datum as @fasta_datum' do
        get :show, {id: fasta_datum.id}
        expect(assigns(:fasta_datum)).to eq(fasta_datum)
      end
    end

    context 'when user did not log in' do
      it 'redirect to login page' do
        get :show, {id: fasta_datum.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:fasta_datum1) { create(:fasta_datum) }
    let!(:fasta_datum2) { create(:fasta_datum) }

    context 'when user logged in' do
      before do
        sign_in user
      end

      it 'destroys the requested fasta_datum' do
        delete :destroy, {id: fasta_datum1.id}
        expect(FastaDatum.all.pluck(:id)).to match([fasta_datum2.id])
      end

      it 'redirects to the fasta_data list' do
        delete :destroy, {id: fasta_datum1.id}
        expect(response).to redirect_to(fasta_data_url)
      end
    end

    context 'when user did not log in' do
      it 'redirect to login page' do
        delete :destroy, {id: fasta_datum1.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end

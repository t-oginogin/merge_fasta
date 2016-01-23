require 'rails_helper'

RSpec.describe FastaDataController, :type => :controller do
  def create_fasta(user_id, filename)
    create(:fasta_datum, user_id: user_id, filename: filename)
  end

  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  describe 'GET index' do
    let!(:fasta_data) {
      fasta_data = []
      Timecop.freeze(Date.today) do
        fasta_data << create_fasta(user1.id, 'test1.fasta')
        fasta_data << create_fasta(user2.id, 'test2.fasta')
      end
      Timecop.freeze(Date.yesterday) do
        fasta_data << create_fasta(user1.id, 'test3.fasta')
        fasta_data << create_fasta(user2.id, 'test4.fasta')
      end
      fasta_data
    }

    context 'when user logged in' do
      before do
        sign_in user1
      end

      it "is listed only user's data" do
        get :index
        expect(assigns(:fasta_data).map(&:id)).to eq([fasta_data[2].id, fasta_data[0].id])
      end

      it "is ordered by created_at" do
        get :index
        expect(assigns(:fasta_data).map(&:id)).to eq([fasta_data[2].id, fasta_data[0].id])
      end
    end

    context 'when user did not log in' do
      it 'redirect to login page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET merge' do
    let!(:fasta_data) {
      fasta_data = []
      fasta_data << create_fasta(user1.id, 'test1.fasta')
      fasta_data << create_fasta(user1.id, 'test2.fasta')
      fasta_data << create_fasta(user1.id, 'test3.fasta')
      fasta_data << create_fasta(user2.id, 'test4.fasta')
      fasta_data
    }

    let(:targets) {
      fasta_data.each_with_object({}) {|fasta_datum, targets| targets[fasta_datum.id] = true}
    }

    context 'when user logged in' do
      before do
        sign_in user1
      end

      it 'returns merged content only the user owns' do
        get :merge, {targets: targets}
        expect(assigns(:content)).to have_content(">#{File.basename(fasta_data[0].filename, '.*')}")
        expect(assigns(:content)).to have_content(">#{File.basename(fasta_data[1].filename, '.*')}")
        expect(assigns(:content)).to have_content(">#{File.basename(fasta_data[2].filename, '.*')}")
        expect(assigns(:content)).not_to have_content(">#{File.basename(fasta_data[3].filename, '.*')}")
      end
    end

    context 'when user did not log in' do
      it 'redirect to login page' do
        get :merge, {targets: targets}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET show' do
    let!(:fasta_datum1) { create_fasta(user1.id, 'test1.fasta') }
    let!(:fasta_datum2) { create_fasta(user2.id, 'test2.fasta') }

    context 'when user logged in' do
      before do
        sign_in user1
      end

      context 'when the data is owned by the user' do
        it 'assigns the requested fasta_datum as @fasta_datum' do
          get :show, {id: fasta_datum1.id}
          expect(assigns(:fasta_datum)).to eq(fasta_datum1)
        end
      end

      context 'when the data is owned by other user' do
        it 'redirect to 404 error page' do
          get :show, {id: fasta_datum2.id}
          expect(response).to render_template(:error_404)
        end
      end
    end

    context 'when user did not log in' do
      it 'redirect to login page' do
        get :show, {id: fasta_datum1.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:fasta_datum1) { create_fasta(user1.id, 'test1.fasta') }
    let!(:fasta_datum2) { create_fasta(user1.id, 'test2.fasta') }
    let!(:fasta_datum3) { create_fasta(user2.id, 'test3.fasta') }

    context 'when user logged in' do
      before do
        sign_in user1
      end

      context 'when the data is owned by the user' do
        it 'destroys the requested fasta_datum' do
          delete :destroy, {id: fasta_datum1.id}
          expect(FastaDatum.all.pluck(:id)).to match([fasta_datum2.id, fasta_datum3.id])
        end
      end

      context 'when the data is owned by other user' do
        it 'dose not destroy the requested fasta_datum' do
          delete :destroy, {id: fasta_datum3.id}
          expect(FastaDatum.all.pluck(:id)).to match([fasta_datum1.id, fasta_datum2.id, fasta_datum3.id])
        end

        it 'redirect to 404 error page' do
          delete :destroy, {id: fasta_datum3.id}
          expect(response).to render_template(:error_404)
        end
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

  describe 'GET destroy_all' do
    let!(:fasta_datum1) { create_fasta(user1.id, 'test1.fasta') }
    let!(:fasta_datum2) { create_fasta(user1.id, 'test2.fasta') }
    let!(:fasta_datum3) { create_fasta(user2.id, 'test3.fasta') }

    context 'when user logged in' do
      before do
        sign_in user1
      end

      it 'destroy all data the user owns' do
        get :destroy_all
        expect(FastaDatum.all.pluck(:id)).to match([fasta_datum3.id])
      end
    end

    context 'when user did not log in' do
      it 'redirect to login page' do
        get :destroy_all
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end

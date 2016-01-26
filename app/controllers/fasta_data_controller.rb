class FastaDataController < ApplicationController
  before_action :authenticate_user!
  before_action :set_fasta_datum, only: [:show, :edit, :update, :destroy]

  # GET /fasta_data
  # GET /fasta_data.json
  def index
    @fasta_data = current_user.fasta_data.order(:last_modified_at)
  end

  # GET /fasta_data/1
  # GET /fasta_data/1.json
  def show
  end

  # GET /fasta_data/new
  def new
    @fasta_datum = current_user.fasta_data.build
  end

  # GET /fasta_data/1/edit
  def edit
  end

  # POST /fasta_data
  # POST /fasta_data.json
  def create
    @fasta_datum = current_user.fasta_data.build(fasta_datum_params)

    respond_to do |format|
      if @fasta_datum.save!
        format.html { redirect_to @fasta_datum, notice: 'Fasta datum was successfully created.' }
        format.json { render :show, status: :created, location: @fasta_datum }
      end
    end
  end

  # PATCH/PUT /fasta_data/1
  # PATCH/PUT /fasta_data/1.json
  def update
    respond_to do |format|
      if @fasta_datum.update!(fasta_datum_params)
        format.html { redirect_to @fasta_datum, notice: 'Fasta datum was successfully updated.' }
        format.json { render :show, status: :ok, location: @fasta_datum }
      end
    end
  end

  # DELETE /fasta_data/1
  # DELETE /fasta_data/1.json
  def destroy
    @fasta_datum.destroy
    respond_to do |format|
      format.html { redirect_to fasta_data_url, notice: 'Fasta datum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def destroy_all
    current_user.fasta_data.each(&:destroy)

    redirect_to fasta_data_url
  end

  def merge
    target_ids = (params[:targets] || {}).keys.map(&:to_i)
    # only user's data
    # order by last modified date of original file
    fasta_data = current_user.fasta_data.where(id: target_ids).order(:last_modified_at)
    @content = FastaDatum.merged_content(fasta_data)
  end

  def upload
    file_dates = params[:file_dates].map { |data| data.split(',') }.to_h
    (params[:files] || []).each do |file|
      next unless %w(.fasta .fa .seq).include? File.extname(file.original_filename)
      # last modified date of original file
      last_modified = Time.parse(file_dates[file.original_filename]) rescue Time.current
      current_user.fasta_data.create!(filename: file.original_filename,
                                      data: file.read,
                                      last_modified_at: last_modified)
    end

    respond_to do |format|
      format.html { redirect_to fasta_data_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fasta_datum
      @fasta_datum = FastaDatum.find(params[:id])
      if @fasta_datum.user_id != current_user.id
        raise ActiveRecord::RecordNotFound
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fasta_datum_params
      params.require(:fasta_datum).permit(:filename, :data)
    end
end

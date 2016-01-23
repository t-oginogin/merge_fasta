class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    return fasta_data_path
  end
end

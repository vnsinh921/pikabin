class DocumentsController < ApplicationController
#  before_action :set_document, only: [:show, :destroy]
  before_action :set_document, only: [:show, :destroy]
#  skip_before_filter :verify_authenticity_token, :only => [:create]
  skip_before_action :verify_authenticity_token, :only => [:create]
  rescue_from OpenSSL::Cipher::CipherError do |exception|
    message = "Decrypt fail #{params}"
    Rails.logger.error message
    redirect_to not_found_url
  end

  def show
    respond_to do |format|
      format.html {}
      format.json {

      }
      format.raw {
        render plain: @document.content_decrypted, content_type: 'text/plain'
      }
    end
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)

    @res = {
      message: [],
      uri: ''
    }

    respond_to do |format|
      if @document.save
        token = TokenService.build(friendly_id: @document.friendly_id, password: @document.password)
        @res[:uri] = request.base_url + request.original_fullpath + token
        res_status = 201
      else
        @res[:message] = @document.errors.full_messages
        res_status = 400
      end

      format.json { render :new, status: res_status }
      format.html {render json: @res, status: res_status}
    end
  end

  def destroy
    @res = {
      error: '',
      status: 204
    }

    if not @document.destroy
      @res[:error] = 'Could not delete'
      @res[:status] = 400
    end

    respond_to do |format|
      format.json { render json: @res, status: @res[:status] }
      format.js {}
    end
  end

  private
    def set_document
      token = TokenService.extract(token: params[:token])
      @document = Document.find_and_validate_by_friendly_id(token[:friendly_id])

      if @document.nil?
        redirect_to not_found_url
        return
      end

      # Set password to decrypt
      @document.password = token[:password]
    end

    def document_params
      params.require(:document).permit(:content, :title, :syntax, :expired_at)
    end
end

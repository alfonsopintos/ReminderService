class TextsController < ApplicationController
  before_action :set_text, only: [:show, :edit, :update, :destroy]
  before_filter :restrict_access_text
  # GET /texts
  # GET /texts.json
  def index
    @texts = Text.all
  end

  # GET /texts/1
  # GET /texts/1.json
  def show
  end

  # GET /texts/new
  def new
    @text = Text.new
  end

  # GET /texts/1/edit
  def edit
  end

  # POST /texts
  # POST /texts.json
  def create
    @event_recurrence = EventRecurrence.new(event_recurrence_params)
    @text = Text.new(text_params)
    @text.event_recurrence = @event_recurrence
    
    respond_to do |format|
      if @text.save && @event_recurrence.save
        format.html { redirect_to @text, notice: 'Text was successfully created.' }
        format.json { render :show, status: :created, location: @text }
      else
        format.html { render :new }
        format.json { render json: @text.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /texts/1
  # PATCH/PUT /texts/1.json
  def update
    respond_to do |format|
      if @text.update(text_params)
        format.html { redirect_to @text, notice: 'Text was successfully updated.' }
        format.json { render :show, status: :ok, location: @text }
      else
        format.html { render :edit }
        format.json { render json: @text.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /texts/1
  # DELETE /texts/1.json
  def destroy
    @text.destroy
    respond_to do |format|
      format.html { redirect_to texts_url, notice: 'Text was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def restrict_access_text
      authenticate_or_request_with_http_token do |token, options|
      ApiKey.exists?(access_token: token)
      # ApiKey.where searches through our database until it finds an instance -- 
      # where the access_token and the token being passed in by the user are equal.
      # .take retrieves a record without any order. since there is only one...it takes the hash we need
      api_key = ApiKey.where(access_token: token).take   
      # @client is being set equal to the value of the client_id key in the api_key hash
      @client = Client.find(api_key['client_id'].to_i)
      # email_counter is a method in the client model that increments the client email_count by one every time its called
      @client.text_counter 
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_text
      @text = Text.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def text_params
      params.require(:text).permit(:cell_phone, :text_reminder, :event_recurrence_id)
    end

    def event_recurrence_params
      params.require(:event_recurrence).permit(:object_id, :start_date, :end_date, :every, :interval)
    end
end

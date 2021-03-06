class CallsController < ApplicationController
  before_action :set_call, only: [:show, :edit, :update, :destroy]
  before_filter :restrict_access_call
  # GET /calls
  # GET /calls.json
  def index
    @calls = Call.all
  end

  # GET /calls/1
  # GET /calls/1.json
  def show
  end

  # GET /calls/new
  def new
    @call = Call.new
  end

  # GET /calls/1/edit
  def edit
  end

  # POST /calls
  # POST /calls.json
  def create
    @event_recurrence = EventRecurrence.new(event_recurrence_params)
    @call = Call.new(call_params)
    @call.event_recurrence = @event_recurrence 

    respond_to do |format|
      if @call.save && @event_recurrence.save
        format.html { redirect_to @call, notice: 'Call was successfully created.' }
        format.json { render :show, status: :created, location: @call }
      else
        format.html { render :new }
        format.json { render json: @call.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calls/1
  # PATCH/PUT /calls/1.json
  def update
    respond_to do |format|
      if @call.update(call_params)
        format.html { redirect_to @call, notice: 'Call was successfully updated.' }
        format.json { render :show, status: :ok, location: @call }
      else
        format.html { render :edit }
        format.json { render json: @call.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calls/1
  # DELETE /calls/1.json
  def destroy
    @call.destroy
    respond_to do |format|
      format.html { redirect_to calls_url, notice: 'Call was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def restrict_access_call
      authenticate_or_request_with_http_token do |token, options|
      ApiKey.exists?(access_token: token)
      # ApiKey.where searches through our database until it finds an instance -- 
      # where the access_token and the token being passed in by the user are equal.
      # .take retrieves a record without any order. since there is only one...it takes the hash we need
      api_key = ApiKey.where(access_token: token).take   
      # @client is being set equal to the value of the client_id key in the api_key hash
      @client = Client.find(api_key['client_id'].to_i)
      # call_counter is a method in the client model that increments the client email_count by one every time its called
      @client.call_counter 
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_call
      @call = Call.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def call_params
      params.require(:call).permit(:cell_phone, :call_reminder, :event_recurrence_id)
    end
    
    def event_recurrence_params
      params.require(:event_recurrence).permit(:object_id, :start_date, :end_date, :every, :interval)
    end
end

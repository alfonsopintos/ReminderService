class EmailsController < ApplicationController
  before_action :set_email, only: [:show, :edit, :update, :destroy]
  before_filter :restrict_access_email
  # GET /emails
  # GET /emails.json
  def index
    @emails = Email.all
  end

  # GET /emails/1
  # GET /emails/1.json
  def show
  end

  # GET /emails/new
  def new
    @email = Email.new
  end

  # GET /emails/1/edit
  def edit
  end

  # POST /emails
  # POST /emails.json
  def create
    @email = Email.new(email_params)
    @event_recurrence = EventRecurrence.new(event_recurrence_params)
    @email.event_recurrence = @event_recurrence  

    respond_to do |format|
      if @email.save && @event_recurrence.save
        format.html { redirect_to @email, notice: 'Email was successfully created.' }
        format.json { render :show, status: :created, location: @email }
      else
        format.html { render :new }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /emails/1
  # PATCH/PUT /emails/1.json
  def update
    respond_to do |format|
      if @email.update(email_params)
        format.html { redirect_to @email, notice: 'Email was successfully updated.' }
        format.json { render :show, status: :ok, location: @email }
      else
        format.html { render :edit }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emails/1
  # DELETE /emails/1.json
  def destroy
    @email.destroy
    respond_to do |format|
      format.html { redirect_to emails_url, notice: 'Email was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

   def restrict_access_email
    authenticate_or_request_with_http_token do |token, options|
      ApiKey.exists?(access_token: token)
      # ApiKey.where searches through our database until it finds an instance -- 
      # where the access_token and the token being passed in by the user are equal.
      # .take retrieves a record without any order. since there is only one...it takes the hash we need
      api_key = ApiKey.where(access_token: token).take   
      # @client is being set equal to the value of the client_id key in the api_key hash
      @client = Client.find(api_key['client_id'].to_i)
      # email_counter is a method in the client model that increments the client email_count by one every time its called
      @client.email_counter 
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_email
      @email = Email.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_params
      params.require(:email).permit(:email_address, :event_recurrence_id, :email_reminder)
    end

    def event_recurrence_params
      params.require(:event_recurrence).permit(:object_id, :start_date, :end_date, :every, :interval)
    end
end

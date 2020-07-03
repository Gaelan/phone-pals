class CalleesController < ApplicationController
  before_action :set_callee, only: %i[show edit update destroy]

  # GET /callees
  # GET /callees.json
  def index
    authorize Callee
    unless current_user.student?
      flash.alert = 'Not authorized.'
      redirect_to root_path
    end
    @callees = policy_scope(Callee)
  end

  # GET /callees/1
  # GET /callees/1.json
  def show
    @relationship = Relationship.find_by(callee: @callee, user: current_user)
    @relationship.ensure_code!
    @call_number = ENV['TWILIO_NUMBER']
  end

  # GET /callees/new
  def new
    @callee = Callee.new
    @callee.organization = Organization.find(params[:organization_id])
    authorize @callee
  end

  # GET /callees/1/edit
  def edit; end

  # POST /callees
  # POST /callees.json
  def create
    @callee = Callee.new(callee_params)
    @callee.organization = Organization.find(params[:organization_id])
    authorize @callee

    respond_to do |format|
      if @callee.save
        format.html do
          redirect_to @callee.organization,
                      notice: 'Callee was successfully created.'
        end
        format.json { render :show, status: :created, location: @callee }
      else
        format.html { render :new }
        format.json do
          render json: @callee.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /callees/1
  # PATCH/PUT /callees/1.json
  def update
    respond_to do |format|
      if @callee.update(callee_params)
        format.html do
          redirect_to @callee.organization,
                      notice: 'Callee was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @callee }
      else
        format.html { render :edit }
        format.json do
          render json: @callee.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /callees/1
  # DELETE /callees/1.json
  def destroy
    @callee.destroy
    respond_to do |format|
      format.html do
        redirect_to @callee.organization,
                    notice: 'Callee was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private # Use callbacks to share common setup or constraints between actions.
  def set_callee
    @callee = Callee.find(params[:id])
    authorize @callee
  end

  # Only allow a list of trusted parameters through.
  def callee_params
    params.require(:callee).permit(:first_name, :last_name, :bio, :phone_number)
  end
end

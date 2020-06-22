class CalleesController < ApplicationController
  before_action :set_callee, only: [:show, :edit, :update, :destroy]

  # GET /callees
  # GET /callees.json
  def index
    authorize Callee
    unless current_user.student?
      flash.alert = "Not authorized."
      redirect_to root_path
    end
    @callees = policy_scope(Callee)
  end

  # GET /callees/1
  # GET /callees/1.json
  def show
  end

  # GET /callees/new
  def new
    @callee = Callee.new
    @callee.organization = Organization.find(params[:organization_id])
    authorize @callee
  end

  # GET /callees/1/edit
  def edit
  end

  # POST /callees
  # POST /callees.json
  def create
    @callee = Callee.new(callee_params)
    @callee.organization = Organization.find(params[:organization_id])
    authorize @callee

    respond_to do |format|
      if @callee.save
        format.html { redirect_to @callee.organization, notice: 'Callee was successfully created.' }
        format.json { render :show, status: :created, location: @callee }
      else
        format.html { render :new }
        format.json { render json: @callee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /callees/1
  # PATCH/PUT /callees/1.json
  def update
    respond_to do |format|
      if @callee.update(callee_params)
        format.html { redirect_to @callee.organization, notice: 'Callee was successfully updated.' }
        format.json { render :show, status: :ok, location: @callee }
      else
        format.html { render :edit }
        format.json { render json: @callee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /callees/1
  # DELETE /callees/1.json
  def destroy
    @callee.destroy
    respond_to do |format|
      format.html { redirect_to @callee.organization, notice: 'Callee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_callee
      @callee = Callee.find(params[:id])
      authorize @callee
    end

    # Only allow a list of trusted parameters through.
    def callee_params
      params.require(:callee).permit(:first_name, :last_name, :bio)
    end
end

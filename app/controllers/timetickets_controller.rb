class TimeticketsController < ApplicationController
  before_action :set_timeticket, only: [:show, :edit, :update, :destroy]

  # GET /timetickets
  # GET /timetickets.json
  def index
    @timetickets = Timeticket.all
  end

  # GET /timetickets/1
  # GET /timetickets/1.json
  def show
  end

  # GET /timetickets/new
  def new
    @timeticket = Timeticket.new
  end

  # GET /timetickets/1/edit
  def edit
  end

  # POST /timetickets
  # POST /timetickets.json
  def create
    @timeticket = Timeticket.new(timeticket_params)

    respond_to do |format|
      if @timeticket.save
        format.html { redirect_to @timeticket, notice: 'Timeticket was successfully created.' }
        format.json { render :show, status: :created, location: @timeticket }
      else
        format.html { render :new }
        format.json { render json: @timeticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /timetickets/1
  # PATCH/PUT /timetickets/1.json
  def update
    respond_to do |format|
      if @timeticket.update(timeticket_params)
        format.html { redirect_to @timeticket, notice: 'Timeticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @timeticket }
      else
        format.html { render :edit }
        format.json { render json: @timeticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /timetickets/1
  # DELETE /timetickets/1.json
  def destroy
    @timeticket.destroy
    respond_to do |format|
      format.html { redirect_to timetickets_url, notice: 'Timeticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timeticket
      @timeticket = Timeticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def timeticket_params
      params.require(:timeticket).permit(:banana_id, :time)
    end
end

class GardensController < ApplicationController
  before_action :set_garden,:set_bananas, only: [:show, :edit, :update, :destroy]
  #todo what for?

  # GET /Gardens
  # GET /Gardens.json
  def index
    @gardens = Garden.all
  end

  # GET /Gardens/1
  # GET /Gardens/1.json
  def show
    # set_bananas
    Thread.new do
      puts "starting scheduler"
      @garden.run_scheduler
    end
  end

  # GET /Gardens/new
  def new
    @garden = Garden.new
  end

  # GET /Gardens/1/edit
  def edit
  end

  # def updategrid #todo !!! ajax/js
  #   respond_to do |format|
  #     format.js { render :js => "my_function();" }
  #   end
  # end

  # POST /Gardens
  # POST /Gardens.json
  def create
    @garden = Garden.create(garden_params)
    # @garden.newfield
    respond_to do |format|
      if @garden.save
        format.html { redirect_to @garden, notice: 'Garden was successfully created.' }
        format.json { render :show, status: :created, location: @garden }
      else
        format.html { render :new }
        format.json { render json: @garden.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Gardens/1
  # PATCH/PUT /Gardens/1.json
  def update
    respond_to do |format|
      if @garden.update(garden_params)
        format.html { redirect_to @garden, notice: 'Garden was successfully updated.' }
        format.json { render :show, status: :ok, location: @garden }
      else
        format.html { render :edit }
        format.json { render json: @garden.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Gardens/1
  # DELETE /Gardens/1.json
  def destroy
    @garden.destroy
    respond_to do |format|
      format.html { redirect_to gardens_url, notice: 'Garden was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_garden
      @garden = Garden.find(params[:id])
    end

    def set_bananas
      @bananas = @garden.bananas
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def garden_params
      params.require(:garden).permit(:sizex, :sizey)
    end
end

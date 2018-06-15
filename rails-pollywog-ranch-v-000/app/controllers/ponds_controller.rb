class PondsController < ApplicationController
  before_action :set_pond, only: [:show, :edit, :update, :destroy]

  def index
    @ponds = Pond.all
  end

  def show
  end

  def new
    @pond = Pond.new
  end

  def edit
  end

  def create
    @pond = Pond.new(pond_params)
    respond_to do |format|
      if @pond.save
        format.html { redirect_to @pond, notice: 'Pond was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @pond.update(pond_params)
        format.html { redirect_to @pond, notice: 'Pond was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @pond.destroy
    respond_to do |format|
      format.html { redirect_to ponds_url, notice: 'Pond was successfully destroyed.' }
    end
  end

  private
    def set_pond
      @pond = Pond.find(params[:id])
    end

    def pond_params
      params.require(:pond).permit(:name, :water_type)
    end
end

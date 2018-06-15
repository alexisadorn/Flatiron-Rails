class FrogsController < ApplicationController

  before_action :set_frog, only: [:show, :edit, :update, :destroy]

  def index
    @frogs = Frog.all
  end

  def show
  end

  def new
    @frog = Frog.new
  end

  def edit
  end

  def create
    @frog = Frog.new(frog_params)

    respond_to do |format|
      if @frog.save
        format.html { redirect_to @frog, notice: 'Frog was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @frog.update(frog_params)
        format.html { redirect_to @frog, notice: 'Frog was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @frog.destroy
    respond_to do |format|
      format.html { redirect_to frogs_url, notice: 'Frog was successfully destroyed.' }
    end
  end

  private
    def set_frog
      @frog = Frog.find(params[:id])
    end

    def frog_params
      params.require(:frog).permit(:name, :color, :pond_id)
    end
end

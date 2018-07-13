class MaterialsController < ApplicationController
  before_action :set_material, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :authenticate_user!

  # GET /materials
  # GET /materials.json
  def index
    @materials = Material.where(user_id: current_user).order("created_at DESC")
  end

  # GET /materials/1
  # GET /materials/1.json
  def show
    @reviews = Review.where(material_id: @material.id).order("created_at DESC")
  end

  # GET /materials/new
  def new
    @material = current_user.materials.build
  end

  # GET /materials/1/edit
  def edit
  end

  # POST /materials
  # POST /materials.json
  def create
    @material = current_user.materials.build(material_params)

    respond_to do |format|
      if @material.save
        format.html { redirect_to @material, notice: 'Material was successfully created.' }
        format.json { render :show, status: :created, location: @material }
      else
        format.html { render :new }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /materials/1
  # PATCH/PUT /materials/1.json
  def update
    respond_to do |format|
      if @material.update(material_params)
        format.html { redirect_to @material, notice: 'Material was successfully updated.' }
        format.json { render :show, status: :ok, location: @material }
      else
        format.html { render :edit }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /materials/1
  # DELETE /materials/1.json
  def destroy
    @material.destroy
    respond_to do |format|
      format.html { redirect_to materials_url, notice: 'Material was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
      @vote = @material.liked_by current_user
      redirect_to @material
  end


      def unvote
          @material.unliked_by current_user
          redirect_to @material
      end
 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material
      @material = Material.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def material_params
      params.require(:material).permit(:title, :content)
    end
end

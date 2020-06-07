class SectionsController < ApplicationController
  layout 'admin'
  before_action :find_pages, only: %i[new create edit update]
  before_action :set_section_count, only: %i[new create edit update]

  def index
    @sections = Section.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      flash[:notice] = 'Section created succesfully'
      redirect_to(sections_path)
    else
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      flash[:notice] = 'Section updated succesfully'
      redirect_to(section_path(@section))
    else
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy
    flash[:notice] = "Section '#{@section.name}' destroyed succesfully"
    redirect_to(sections_path)
  end

  private

  def section_params
    params.require(:section).permit(
      :name, :position, :content_type, :content, :visible, :page_id
    )
  end

  def find_pages
    @pages = Page.sorted
  end

  def set_section_count
    @section_count = Section.count
    @section_count += 1 if params[:action].in?(%w[new create])
  end
end

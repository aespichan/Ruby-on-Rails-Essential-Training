class PagesController < ApplicationController
  layout 'admin'
  before_action :find_subjects, only: %i[new create edit update]
  before_action :set_page_count, only: %i[new create edit update]

  def index
    @pages = Page.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:notice] = 'Page created succesfully'
      redirect_to(pages_path)
    else
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = 'Page updated succesfully'
      redirect_to(page_path(@page))
    else
      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = "Page '#{@page.name}'' destroyed succesfully"
    redirect_to(pages_path)
  end

  private

  def page_params
    params.require(:page).permit(
      :name, :position, :permalink, :visible, :subject_id
    )
  end

  def find_subjects
    @subjects = Subject.sorted
  end

  def set_page_count
    @page_count = Page.count
    @page_count += 1 if params[:action].in?(%w[new create])
  end
end

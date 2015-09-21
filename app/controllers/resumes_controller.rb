class ResumesController < ApplicationController
  include SkillsParsing

  def index
    @resumes = Resume.includes(:skills)
  end

  def new
    @resume = Resume.new
  end

  def edit
    @resume = Resume.find(params[:id])
  end

  def show
    @resume = Resume.find(params[:id])

    query = VacanciesBySkillsQuery.new(@resume.skills)

    @full_intersect_vacancies = query.full_intersect.includes(:skills)
    @partial_intersect_vacancies = query.partial_intersect.includes(:skills)
  end

  def create
    @resume = Resume.new(permitted_params)
    @resume.skills = SkillsByTitlesQuery.find_or_create(parse_skills(params[:resume][:skills]))

    if @resume.save
      redirect_to resumes_path
    else
      render :new
    end
  end

  def update
    @resume = Resume.find(params[:id])
    @resume.assign_attributes(permitted_params)
    @resume.skills = SkillsByTitlesQuery.find_or_create(parse_skills(params[:resume][:skills]))

    if @resume.save
      redirect_to resumes_path
    else
      render :edit
    end
  end

  private

  def permitted_params
    params[:resume].permit(:fio, :state, :salary, :contacts)
  end
end

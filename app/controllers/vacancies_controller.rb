class VacanciesController < ApplicationController
  include SkillsParsing

  def index
    @vacancies = Vacancy.includes(:skills)
  end

  def show
    @vacancy = Vacancy.find(params[:id])

    query = ResumesBySkillsQuery.new(@vacancy.skills)

    @full_intersect_resumes = query.full_intersect.includes(:skills)
    @partial_intersect_resumes = query.partial_intersect.includes(:skills)
  end

  def new
    @vacancy = Vacancy.new
  end

  def edit
    @vacancy = Vacancy.find(params[:id])
  end

  def create
    @vacancy = Vacancy.new(permitted_params)
    @vacancy.skills = SkillsByTitlesQuery.find_or_create(parse_skills(params[:vacancy][:skills]))

    if @vacancy.save
      redirect_to vacancies_path
    else
      render :new
    end
  end

  def update
    @vacancy = Vacancy.find(params[:id])
    @vacancy.assign_attributes(permitted_params)
    @vacancy.skills = SkillsByTitlesQuery.find_or_create(parse_skills(params[:vacancy][:skills]))

    if @vacancy.save
      redirect_to vacancies_path
    else
      render :edit
    end
  end

  private

  def permitted_params
    params[:vacancy].permit(:title, :expires_at, :salary, :contacts)
  end
end

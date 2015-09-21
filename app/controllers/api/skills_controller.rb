class Api::SkillsController < ApplicationController
  def index
    @skills = Skill.where("title LIKE ?", "#{params[:q] || ''}_%")
    render json: @skills.pluck(:title)
  end
end

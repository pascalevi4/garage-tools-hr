module SkillsParsing
  extend ActiveSupport::Concern

  private
  def parse_skills(skills)
    skills.strip.split(',').collect(&:strip).uniq
  end
end
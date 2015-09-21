class SkillsByTitlesQuery
  def self.find_or_create(titles)
    new(titles).find_or_create
  end

  def initialize(titles)
    @titles = titles
  end

  def find_or_create
    skills + non_exist_skill_titles.map { |title| Skill.create(title: title) }
  end

  private
  def skills
    @skills ||= Skill.where(title: @titles)
  end

  def non_exist_skill_titles
    @titles - skills.map(&:title)
  end
end
class ResumesBySkillsQuery
  def initialize(skills)
    @skills = skills
  end

  def full_intersect
    @full_intersect ||= base_query.group("resumes.id")
      .having("count(skill_id) = ?", skills_count)
  end

  def partial_intersect
    result = base_query.uniq
    if full_intersect_ids.any?
      result = result.where("resume_id not in (?)", full_intersect_ids)
    end
    result
  end

  private

  def base_query
    Resume.joins(:resume_skills)
      .where("skill_id in (?) and state = ?", skill_ids, state)
      .order("salary ASC")
  end

  def full_intersect_ids
    full_intersect.map(&:id)
  end

  def skill_ids
    @skill_ids ||= @skills.map(&:id)
  end

  def skills_count
    @skills_count ||= @skills.count
  end

  def state
    Resume.states[:free]
  end
end
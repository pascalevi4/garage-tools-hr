class VacanciesBySkillsQuery
  def initialize(skills)
    @skills = skills
  end

  def full_intersect
    @full_intersect ||= base_query.where("id in (#{arrays_intersection_subquery})")
  end

  def partial_intersect
    result = base_query.joins(:vacancy_skills).where("skill_id in (?)", skill_ids).uniq
    if full_intersect_ids.any?
      result = result.where("vacancy_id not in (?)", full_intersect_ids)
    end
    result
  end

  private

  def base_query
    Vacancy.where("expires_at > ?", Time.zone.now)
           .order("salary DESC")
  end

  def arrays_intersection_subquery
    "select vacancy_id from vacancy_skills
      group by vacancy_id
      having array[#{skill_ids.join(',')}] @> array_agg(skill_id)"
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
end
class CreateVacancySkills < ActiveRecord::Migration
  def change
    create_table :vacancy_skills do |t|
      t.integer :vacancy_id
      t.integer :skill_id

      t.timestamps null: false
    end
    add_index :vacancy_skills, [:vacancy_id, :skill_id]
  end
end

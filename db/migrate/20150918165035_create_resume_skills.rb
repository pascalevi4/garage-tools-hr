class CreateResumeSkills < ActiveRecord::Migration
  def change
    create_table :resume_skills do |t|
      t.integer :resume_id
      t.integer :skill_id

      t.timestamps null: false
    end
    add_index :resume_skills, [:resume_id, :skill_id]
  end
end

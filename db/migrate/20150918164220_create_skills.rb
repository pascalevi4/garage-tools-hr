class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :title, uniq: true

      t.timestamps null: false
    end
    add_index :skills, :title, order: {title: :text_pattern_ops}
  end
end

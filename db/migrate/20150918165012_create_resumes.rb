class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.text :fio
      t.string :contacts
      t.integer :state
      t.decimal :salary

      t.timestamps null: false
    end
  end
end

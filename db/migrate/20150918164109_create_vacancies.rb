class CreateVacancies < ActiveRecord::Migration
  def change
    create_table :vacancies do |t|
      t.string :title
      t.datetime :expires_at
      t.decimal :salary
      t.text :contacts

      t.timestamps null: false
    end
  end
end

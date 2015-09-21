# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


read  = Skill.create(title: 'read')
write = Skill.create(title: 'write')
english = Skill.create(title: 'english')
count = Skill.create(title: 'count')

vacancy = FactoryGirl.create :vacancy, title: "Read vacancy"
vacancy.skills << [read]
vacancy = FactoryGirl.create :vacancy, title: "Count vacancy"
vacancy.skills << [count]
vacancy = FactoryGirl.create :vacancy, title: "Read & write vacancy"
vacancy.skills << [read, write]
vacancy = FactoryGirl.create :vacancy, title: "Read & write & english vacancy"
vacancy.skills << [read, write, english]
vacancy = FactoryGirl.create :vacancy, title: "English vacancy"
vacancy.skills << [english]
vacancy = FactoryGirl.create :vacancy, title: "English & count vacancy"
vacancy.skills << [english, count]

resume = FactoryGirl.create :resume
resume.skills << [read]
resume = FactoryGirl.create :resume
resume.skills << [read, count]
resume = FactoryGirl.create :resume
resume.skills << [read, english]
resume = FactoryGirl.create :resume
resume.skills << [read, write]
resume = FactoryGirl.create :resume
resume.skills << [read, write, count]
resume = FactoryGirl.create :resume
resume.skills << [read, write, count, english]

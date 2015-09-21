FactoryGirl.define do
  factory :skill do
    sequence :title do |n|
      "skill #{n}"
    end
  end

  factory :vacancy do
    title 'vacancy'
    expires_at 30.days.from_now
    salary 100
    contacts 'example'
  end

  factory :resume do
    fio 'Иванов Иван Иванович'
    contacts '8(999)1234567'
    state :free
    salary 111
  end
end
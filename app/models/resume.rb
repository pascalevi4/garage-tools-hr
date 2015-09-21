class Resume < ActiveRecord::Base
  enum state: [:free, :busy]

  validates :fio, presence: true,
    format: { with: /[[:alpha:]]+\s[[:alpha:]]+\s[[:alpha:]]+/ }
  validates :contacts, presence: true,
    format: { with: /(^(\S+)@([a-z0-9-]+)(\.)([a-z]{2,4})(\.?)([a-z]{0,4})+$)|(((8|\+7)-?)?\(?\d{3}\)?-?\d{1}-?\d{1}-?\d{1}-?\d{1}-?\d{1}-?\d{1}-?\d{1})/ }
  validates :state, presence: true
  validates :salary, presence: true, numericality: true

  has_many :resume_skills, dependent: :destroy
  has_many :skills, through: :resume_skills
end

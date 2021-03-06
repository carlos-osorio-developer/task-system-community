class Category
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String

  has_many :tasks

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false}
end

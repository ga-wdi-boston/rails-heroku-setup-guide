class Article < ActiveRecord::Base
  STATUSES = %w{ draft review published }

  CATEGORIES = %w{ software hardware business}

  validates :title, presence: true
  validates :title, uniqueness: true

  validates :category, inclusion: { in: CATEGORIES }
  validates :status, inclusion: { in: STATUSES }
  
end

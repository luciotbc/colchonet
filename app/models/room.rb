class Room < ApplicationRecord
  extend FriendlyId

  belongs_to :user
  has_many :reviews, :dependent => :destroy

  validates_presence_of :title, :location, :slug
  validates_length_of :description, minimum: 30, allow_blank: false

  friendly_id :title, :use => [:slugged, :history]

  scope :most_recent, -> { order('created_at DESC') }

  def complete_name
    "#{title}, #{location}"
  end

  def self.search(query)
    if query.present?
      where(['location LIKE :query OR
              title LIKE :query OR
              description LIKE :query', :query => "%#{query}%"])
    else
      all
    end
  end
end

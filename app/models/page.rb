class Page < ApplicationRecord
  belongs_to :subject, optional: false
  has_many :sections
  has_and_belongs_to_many :admin_users

  scope :visible, -> { where(visible: true) }
  scope :invisible, -> { where(visible: false) }
  scope :sorted, -> { order(:position) }
  scope :newest_first, -> { order("created_at DESC") }

  validates_presence_of :name
  validates_length_of :name, maximum: 255
  validates_presence_of :permalink
  validates_length_of :permalink, within: 3..255
  # for unique values by subject use "scope: subject_id"
  validates_uniqueness_of :permalink
end

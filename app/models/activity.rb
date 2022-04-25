class Activity < ApplicationRecord
	include Activable

	validates :name, :address, :starts_at, :ends_at, presence: true
end

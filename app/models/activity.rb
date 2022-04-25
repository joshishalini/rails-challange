class Activity < ApplicationRecord
	include Activable

	validates_presence_of :name, :address, :starts_at, :ends_at, :if => lambda { |o| o.current_step == "dates" }

	attr_writer :current_step
  
  def current_step
    @current_step || steps.first
  end
  
  def steps
    %w[name address dates]
  end

	def next_step
	  self.current_step = steps[steps.index(current_step)+1]
	end

	def previous_step
	  self.current_step = steps[steps.index(current_step)-1]
	end

	def first_step?
	  current_step == steps.first
	end

	def last_step?
	  current_step == steps.last
	end
end

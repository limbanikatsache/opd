class DashboardController < ApplicationController
  layout nil
  layout 'application', :except => :view
				def index

					concept_ids = ConceptName.find(:all,
				    :conditions => ["name IN (?)",["Additional diagnosis","Diagnosis","primary diagnosis","secondary diagnosis"]]).map(&:concept_id)
					
					@observations = Observation.find(:all, :conditions => ["obs.obs_datetime >= '2016-01-1 12:08:29' AND obs.obs_datetime <= '2016-12-1 12:08:29' AND concept_id IN (?)", concept_ids ])
					
					@times = Hash.new(0)
					@observations.each do |o|

						@times[o.name] += 1
						
					end



				end
				
				def show
				@result = []
					concept_ids = ConceptName.find(:all,
				    :conditions => ["name IN (?)",["Additional diagnosis","Diagnosis",
				    "primary diagnosis","secondary diagnosis"]]).map(&:concept_id)
					@observations = Observation.find(:all, :conditions => ["obs.obs_datetime >= '2016-01-1 12:08:29' AND obs.obs_datetime <= '2016-12-1 12:08:29' AND concept_id IN (?)", concept_ids ])
					@times = Hash.new(0)
					@observations.each do |o|

						@times[o.name] += 1
						
					end


					@result <<{:obs => @times}
					render :json => @result
				end
				
				
end				
# Virus Predictor

# I worked on this challenge [by myself, with: ].
# We spent [#] hours on this challenge.

# EXPLANATION OF require_relative
#
#
require_relative 'state_data'

class VirusPredictor
  def initialize(state_of_origin, density, count)
    @state = state_of_origin
    @population = Population.new(count, density)
  end

  def virus_effects
    print "#{@state} will lose #{@population.predicted_deaths} people in this outbreak"
    puts " and will spread across the state in #{@population.months_to_spread} months.\n\n"
  end
end

class Population
  EXTREME_DENSITY = 200
  HIGH_DENSITY = 150
  NORMAL_DENSITY = 100
  LOW_DENSITY = 50

  def initialize(count, density)
    @count = count
    @density = density
  end

  def predicted_deaths
    (@count * death_factor(@density)).floor
  end

  def months_to_spread
    # We are still perfecting our formula here. The speed is also affected
    # by additional factors we haven't added into this functionality.
    0.0 + speed_increment(@density)
  end

  private

  def is_extreme_density?
    @density >= EXTREME_DENSITY
  end

  def is_high_density?
    @density >= HIGH_DENSITY
  end

  def is_normal_density?
    @density >= NORMAL_DENSITY
  end

  def is_low_density?
    @density >= LOW_DENSITY
  end

  def death_factor(population_density)
      factor = 0.05
      factor = 0.4 if is_extreme_density?
      factor = 0.3 if is_high_density?
      factor = 0.2 if is_normal_density?
      factor = 0.1 if is_low_density?
      factor
  end

  def speed_increment(population_density)
    increment = 2.5
    increment = 0.5 if is_extreme_density?
    increment = 1 if is_high_density?
    increment = 1.5 if is_normal_density?
    increment = 2 if is_low_density?
    increment
  end
end

#=======================================================================

# DRIVER CODE
 # initialize VirusPredictor for each state


alabama = VirusPredictor.new("Alabama", STATE_DATA["Alabama"][:population_density], STATE_DATA["Alabama"][:population])
alabama.virus_effects

jersey = VirusPredictor.new("New Jersey", STATE_DATA["New Jersey"][:population_density], STATE_DATA["New Jersey"][:population])
jersey.virus_effects

california = VirusPredictor.new("California", STATE_DATA["California"][:population_density], STATE_DATA["California"][:population])
california.virus_effects

alaska = VirusPredictor.new("Alaska", STATE_DATA["Alaska"][:population_density], STATE_DATA["Alaska"][:population])
alaska.virus_effects


#=======================================================================
# Reflection Section

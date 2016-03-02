# Virus Predictor

# I worked on this challenge [by myself, with: ].
# We spent [#] hours on this challenge.

# EXPLANATION OF require_relative
#
#
require_relative 'state_data'

class VirusPredictor
  def initialize(state_of_origin, density_value, count)
    @state = state_of_origin
    @population = Population.new(count, density_value)
  end

  def virus_effects
    print "#{@state} will lose #{@population.predicted_deaths} people in this outbreak"
    puts " and will spread across the state in #{@population.months_to_spread} months.\n\n"
  end
end

class Density
  EXTREME_BASE = 200
  HIGH_BASE = 150
  NORMAL_BASE = 100
  LOW_BASE = 50
  TINY_TOP = 49

  def initialize(value)
    @value = value
  end

  def is_extreme?
    @value >= EXTREME_BASE
  end

  def is_high?
    @value >= HIGH_BASE
  end

  def is_normal?
    @value >= NORMAL_BASE
  end

  def is_low?
    @value >= LOW_BASE
  end

  def is_tiny?
    @value <= TINY_TOP
  end

  def death_factor
      factor = 0.4 if is_extreme?
      factor = 0.3 if is_high?
      factor = 0.2 if is_normal?
      factor = 0.1 if is_low?
      factor = 0.05 if is_tiny?
      factor
  end

  def months_to_spread
    # We are still perfecting our formula here. The speed is also affected
    # by additional factors we haven't added into this functionality.

    increment = 0.5 if is_extreme?
    increment = 1.0 if is_high?
    increment = 1.5 if is_normal?
    increment = 2.0 if is_low?
    increment = 2.5 if is_tiny?
    increment
  end

end

class Population
  def initialize(count, density_value)
    @count = count
    @density = Density.new(density_value)
  end

  def predicted_deaths
    (@count * @density.death_factor).floor
  end

  def months_to_spread
    @density.months_to_spread
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

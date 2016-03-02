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
  DENSITY_TYPES = {
    "Extreme" => {base: 200, ceiling: 100000, factor: 0.4, months: 0.5},
    "High" => {base: 150, ceiling: 200, factor: 0.3, months: 1.0},
    "Normal" => {base: 100, ceiling: 150, factor: 0.2, months: 1.5},
    "Low" => {base: 50, ceiling: 100, factor: 0.1, months: 2.0},
    "Tiny" => {base: -100, ceiling: 50, factor: 0.05, months: 2.5}
  }

  def initialize(value)
    @value = value
    @density_type = get_density_type(value)
  end

  def get_density_type(value)
    DENSITY_TYPES.each { |name, data|
      return name if value.between?(data[:base], data[:ceiling])
    }
    return "Tiny"
  end

  def death_factor
      DENSITY_TYPES[@density_type][:factor]
  end

  def months_to_spread
    # We are still perfecting our formula here. The speed is also affected
    # by additional factors we haven't added into this functionality.

    DENSITY_TYPES[@density_type][:months]
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

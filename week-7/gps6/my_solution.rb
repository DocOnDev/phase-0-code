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

class Population
  def initialize(count, density_value)
    @count = count
    @density = DensityFactory.create(density_value)
  end

  def predicted_deaths
    (@count * @density.death_factor).floor
  end

  def months_to_spread
    @density.months_to_spread
  end

end

class DensityFactory
  attr_accessor :name, :ceiling, :floor, :factor, :months

  @@sub_classes = {}

  def self.create density_value
    @@sub_classes.each { |name, _class|
      candidate = _class.new
      return candidate if density_value.between?(candidate.floor, candidate.ceiling)
    }
    raise ArgumentError, 'Density value did not match any known density'
  end

  def self.register_density name
    @@sub_classes[name] = self
  end

  def death_factor
    @factor
  end

  def months_to_spread
    @months
  end
end

class ExtremeDensity < DensityFactory
  TYPE_NAME = "Extreme"
  def initialize
    @name = TYPE_NAME
    @floor = 200
    @ceiling = 100000
    @factor = 0.4
    @months = 0.5
  end
  register_density TYPE_NAME
end

class HighDensity < DensityFactory
  TYPE_NAME = "High"
  def initialize
    @name = TYPE_NAME
    @floor = 150
    @ceiling = 200
    @factor = 0.3
    @months = 1.0
  end
  register_density TYPE_NAME
end

class NormalDensity < DensityFactory
  TYPE_NAME = "Normal"
  def initialize
    @name = TYPE_NAME
    @floor = 100
    @ceiling = 150
    @factor = 0.2
    @months = 1.5
  end
  register_density TYPE_NAME
end

class LowDensity < DensityFactory
  TYPE_NAME = "Low"
  def initialize
    @name = TYPE_NAME
    @floor = 50
    @ceiling = 100
    @factor = 0.1
    @months = 2.0
  end
  register_density TYPE_NAME
end

class TinyDensity < DensityFactory
  TYPE_NAME = "Tiny"
  def initialize
    @name = TYPE_NAME
    @floor = -100
    @ceiling = 50
    @factor = 0.05
    @months = 2.5
  end
  register_density TYPE_NAME
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

# will_error = VirusPredictor.new("Nortonia", -150, 1234567)
# will_error.virus_effects

#=======================================================================
# Reflection Section

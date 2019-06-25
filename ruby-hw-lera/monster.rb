require_relative "character"

class Monster < Character

  def initialize(start_level = 1) 
    super(25, (1..6).to_a, start_level)
  end

  def hit(opponent)
    available_attacks = ['hit'] + @attacks.reject{ |k,v| v == 0 }.keys
    attack_type = available_attacks.sample
    super(opponent, attack_type)
  end

  def increase_level
    super
    increase_max_health_points
    increase_max_hit_power
  end

end

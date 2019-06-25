class Player < Character
  MAX_LEVEL = 10
  attr_accessor :exprience

  def initialize(start_level = 1)
    super(30, (2..5).to_a, start_level)
    @exprience = 0
  end


  def set_results
    set_exprience
    if @exprience >= 10 * (@level ** 2) - (10 * @level)
      increase_level
    end
  end

  def set_exprience
    if @health > 0 
      @exprience += 10
    else 
      @exprience -= 8 
    end
  end

  def increase_level
    super
    choose_improvement
  end

  def choose_improvement
    command = Console.gets('improvement_type')
    case command
    when '1'
      increase_max_health_points
    when '2'
      increase_max_hit_power
    end
  end
end

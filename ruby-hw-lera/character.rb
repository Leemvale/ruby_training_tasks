class Character
  attr_accessor :health
  attr_accessor :mediator
  attr_reader :level

  def initialize(max_health_points, hit_power_range, start_level)
    @max_health_points = max_health_points
    @health = max_health_points
    @hit_power_range = hit_power_range
    @level = start_level
    @can_hit = true
    @attacks = {}
    set_attacks
  end

  def alive? 
    @health > 0
  end

  def take_damage(opponent, damage)
    @health = @health - damage
    log_status(opponent, damage)
  end

  def hit(opponent, type = nil)
    if @can_hit
      type = determine_attack_type(type)
      puts "attack #{type}"

      damage = if type && respond_to?("#{type}_attack_power")
        send("#{type}_attack_power")
      else
        attack_power
      end
      opponent.take_damage(self, damage)
    end
    @can_hit = true
  end

  def reset
    @health = @max_health_points
    set_attacks
  end

  def increase_level
    @level += 1
    @mediator.notify(self, 'LEVEL_UP')
  end

  def block
    @health += attack_power * 2
  end

  def skip_hit
    @can_hit = false
  end

  def determine_attack_type(type)
    if type.nil? && !@attacks.empty?
      type = Console.gets('attack_type')
    end

    if type != 'hit'
      if !@attacks.key?(type.to_sym)
        puts 'You cannot use it for now!'
        return determine_attack_type(nil)
      end

      if @attacks[type.to_sym] > 0
        @attacks[type.to_sym] -= 1
      else
        puts 'You already used it '
        return determine_attack_type(nil)
      end
    end
    type
  end

  def set_attacks
    case @level
    when 1
      @attacks[:special] = 1
    when 2
      @attacks[:special] = 1
      @attacks[:magic] = 1 
    when 3
      @attacks[:special] = 1
      @attacks[:magic] = 1 
      @attacks[:stun] = 1 
      puts @attacks
    when 4..10
      @attacks[:special] = 1
      @attacks[:magic] = 1 
      @attacks[:stun] = 1 
      @attacks[:block] = 1 
    end
  end


  def attack_power
    @hit_power_range.sample
  end

  def special_attack_power
    attack_power * 2
  end

  def magic_attack_power
    attack_power * 3
  end

  def stun_attack_power
    @mediator.notify(self, 'STUN_OPPONENT')
    attack_power
  end

  def block_attack_power
    @mediator.notify(self, 'BLOCK')
    0
  end

  def log_status(opponent, damage)
    puts "#{opponent.class} hits #{self.class} for #{damage} damage. #{self.class} has #{@health} health left"
  end

  def increase_max_health_points
    @max_health_points +=1
    puts "#{self.class}'s health increased. Health: #{@max_health_points}'"
  end

  def increase_max_hit_power
    max_hit_power = @hit_power_range.last + 1
    @hit_power_range << max_hit_power
    puts "#{self.class}'s max hit power increased. Max hit power: #{max_hit_power}'"
  end
end

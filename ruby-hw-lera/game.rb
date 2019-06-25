class Game

  attr_reader :fighters, :monster, :player

  def initialize(monster, player)
    @monster = monster
    @player = player
    @fighters = []
  end

  def start
    choose_order(monster, player)

    puts 'FIGHT!'

    result = Fighting.new(fighters).process
    if result.somebody_died?
      puts result.output
      player.set_results
      return
    end

  end

  def choose_order(monster, player)

    while fighters.empty?
      command = Console.gets('first_move')

      case command
      when 'me'
        fighters << player << monster
      when 'monster'
        fighters << monster << player
      end
    end
  end
end

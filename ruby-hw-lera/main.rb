require_relative "console"
require_relative "game"
require_relative "fighting"
require_relative "character"
require_relative "player"
require_relative "monster"
require_relative "mediator"

level = Console.gets('level').to_i
monster = Monster.new(level)
player = Player.new(level)
mediator = Mediator.new(monster, player)

loop do
  game = Game.new(monster, player)
  game.start

  monster.reset
  player.reset

  command = Console.gets('new_game')
  if command == 'no'
    puts 'さようなら =^_^='
    break;
  end

end

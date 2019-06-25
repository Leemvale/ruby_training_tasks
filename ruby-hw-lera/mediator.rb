class Mediator
    def initialize(monster, player)
      @monster = monster
      @monster.mediator = self
      @player = player
      @player.mediator = self
    end

    def notify(sender, event)
      if event == 'LEVEL_UP' && sender == @player
        puts 'Player increased level!'
        @monster.increase_level
        puts "Payer's level: #{@player.level}, Monster's level: #{@monster.level}"
      end

      if event == 'STUN_OPPONENT'
        opponent = sender == @player ? @monster : @player
        opponent.skip_hit
      end

      if event == 'BLOCK'
        sender == @player ? @player.block : @monster.block
      end
    end
  end
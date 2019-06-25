class Console

  NEW_GAMES     = %w[yes no].freeze
  FIRST_MOVES   = %w[me monster].freeze
  ATTACK_TYPES  = %w[hit special magic stun block].freeze
  IMPROVEMENT_TYPES = %W[1 2].freeze
  LEVELS = %W[1 2 3 4 5 6 7 8 9 10].freeze
  PROMPTS = {
    'new_game'    => 'Do you want to play again?',
    'first_move'  => 'Who will be first?',
    'attack_type' => 'Choose attack type',
    'improvement_type' => "Choose improvement:\n 1)Increase health by 1\n 2)Increase attack power range by 1",
    'level' => 'Choose your level'
  }.freeze

  def self.gets(command_type)
    puts PROMPTS[command_type]
    print '>>'
    command = Console.new(Kernel.gets.strip.split(/\s/).first.downcase) 
    command.gets_until_valid(command_type)
  end

  attr_reader :command

  def initialize(command)
    @command = command
    if command == 'quit'
      puts 'さようなら =^_^='
      exit
    end
  end

  def gets_until_valid(command_type)
    valid_commands = Console.const_get("#{command_type}s".upcase)
    unless valid_commands.include? command
      puts "Invalid command. Valid commands are: #{valid_commands}"
      return Console.gets(command_type)
    end
    command
  end

end

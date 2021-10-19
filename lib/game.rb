# frozen_string_literal: true

class Game
  attr_accessor :human_player, :enemies

  def initialize(player_name, number_of_enemies, enemies_health)
    @human_player = HumanPlayer.new(player_name)
    @players_left = 10
    @enemies_in_sight = []
    @enemies = []
    create_enemies(number_of_enemies, enemies_health)
  end

  def kill_player(player)
    @enemies_in_sight.delete(player)
  end

  def is_still_ongoing?
    if @human_player.life_points.positive? && @enemies.length.zero?
      return @enemies_in_sight.inject(0) { |s, e| s + e.life_points }.positive?
    end

    true
  end

  def menu
    actions = [
      'Chercher une meilleure arme',
      'Chercher à se soigner'
    ]
    @enemies_in_sight.each { |e| actions << "Attaquer #{e.name}" }
    menu = UserActionsMenu.new(actions, @enemies_in_sight, @human_player)

    user_action(menu.menu_choice)
  end

  def show_players
    puts @human_player.show_state
    puts "Il reste actuellement #{@enemies.length} ennemis vivants."
  end

  def enemies_attack
    unless @enemies_in_sight.length.zero?
      @enemies_in_sight.each do |enemy|
        next unless enemy.life_points.positive?

        puts
        enemy.attacks(@human_player)
      end
    end

    wait_return
  end

  def end
    if @human_player.life_points.zero?
      puts 'Fin du jeu, tu as gagné (ouais flemme de faire un truc de fou)'
    else
      puts 'Fin du jeu, tu as perdu (ouais flemme de faire un truc de fou)'
    end
  end

  def new_players_in_sight
    unless @enemies.length.zero?
      dice = rand(1..6)
      case dice
      when 2..4
        @enemies_in_sight << @enemies.pop
      when 5..6
        2.times { @enemies_in_sight << @enemies.pop }
      end
    end
  end

  private

  def create_enemies(number_of_enemies, enemies_health)
    number_of_enemies.times do
      @enemies << Player.new(choose_name, enemies_health)
    end
  end

  def choose_name
    File.read('nat2020.csv')
        .split[rand(123..667_364)]
        .split(';')[1].capitalize
  end

  def user_action(selected)
    system 'clear'

    case selected
    when 0 then @human_player.search_weapon
    when 1 then @human_player.search_health_pack
    else
      @human_player.attacks(@enemies_in_sight[selected - 2])
      kill_player(@enemies_in_sight[selected - 2]) if @enemies_in_sight[selected - 2].life_points.zero?
    end
  end

  def wait_return
    puts
    puts 'Appuie sur Entrée pour continuer'

    loop do
      case $stdin.getch
      when "\r" then break
      when 'q' then exit
      end
    end
  end
end

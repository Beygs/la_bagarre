# frozen_string_literal: true

# Gère le jeu de la v3.0
class Game
  attr_accessor :human_player, :enemies

  def initialize(player_name, number_of_enemies, enemies_health)
    @human_player = HumanPlayer.new(player_name)
    # Ennemis en vue (aucun de base)
    @enemies_in_sight = []
    @enemies = []
    # Appel à la méthode create_enemies qui peuple mon array d'ennemis
    # selon le nombre d'ennemis et leur points de vie voulus
    create_enemies(number_of_enemies, enemies_health)
  end

  def kill_player(player)
    @enemies_in_sight.delete(player)
  end

  def is_still_ongoing?
    # Renvoie true sauf si le joueur est mort ou si tous les ennemis sont morts
    return @enemies_in_sight.inject(0) { |s, e| s + e.life_points }.positive? if @enemies.length.zero?

    return false if @human_player.life_points <= 0

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

  # Ah j'ai oublié de l'utiliser dans mon programme cette méthode... Tant pis
  def show_players
    puts @human_player.show_state
    puts "Il reste actuellement #{@enemies.length} ennemis vivants."
  end

  # Chaque ennemi en vue et vivant attaque le jouer à tour de rôle
  def enemies_attack
    unless @enemies_in_sight.length.zero?
      @enemies_in_sight.each do |enemy|
        next unless enemy.life_points.positive?

        puts
        enemy.attacks(@human_player)
      end
    end

    # Appel à wait_return qui demande au joueur d'appuyer sur Entrée pour continuer
    wait_return
  end

  def end
    if @human_player.life_points.zero?
      puts 'Fin du jeu, tu as perdu (ouais flemme de faire un truc de fou)'
    else
      puts 'Fin du jeu, tu as gagné (ouais flemme de faire un truc de fou)'
    end
  end

  def new_players_in_sight
    unless @enemies.length.zero?
      dice = rand(1..6)
      case dice
      when 2..4
        @enemies_in_sight << @enemies.pop
      when 5..6
        @enemies_in_sight << @enemies.pop
        @enemies_in_sight << @enemies.pop unless @enemies.length.zero?
      end
    end
  end

  private

  # Ajoute des ennemis à @enemies
  def create_enemies(number_of_enemies, enemies_health)
    number_of_enemies.times do
      @enemies << Player.new(choose_name, enemies_health)
    end
  end

  # Choisis 1 nom au hasard dans nat2020.csv
  def choose_name
    File.read('nat2020.csv')
        .split[rand(123..667_364)]
        .split(';')[1].capitalize
  end

  # Gère l'action effectuée par le joueur selon la valeur de selected
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

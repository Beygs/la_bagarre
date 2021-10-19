# frozen_string_literal: true

# Classe qui gère l'affichage et la sélection de l'utilisateur dans les menus
class Menu
  DIFFICULTY = [
    [1, 10],
    [4, 10],
    [4, 20],
    [10, 10],
    [10, 20],
    [20, 20],
    [20, 50],
    [20, 100],
    [30, 100],
    [50, 100],
    [70, 100],
    [80, 200],
    [100, 200],
    [rand(1..100), rand(10..200)],
    [200, 200],
    [2, 10]
  ].freeze

  def initialize(actions)
    @actions = actions
    @selected = 0
    @win_width = IO.console.winsize[1]
  end

  # Méthode qui permet l'affichage du menu en tant que tel
  def display_menu
    actions_display = @actions.dup

    system 'clear'

    puts 'Que veux-tu faire ?'.center(@win_width)
    puts

    # Couleurs inversées pour l'élément sélectionné
    actions_display[@selected] = "\e[7m#{actions_display[@selected]}\e[0m"
    # Affichage des éléments du menu
    puts(actions_display.map { |a| "#{a}\n" })
  end

  # Méthode qui gère les entrées utilisateur
  def menu_choice
    display_menu
    # Boucle qui tourne le tant que l'utilisateur n'a pas appuyé sur Entrée
    loop do
      case $stdin.getch
      # Si l'utilisateur appuie sur Entrée, on sort de la boucle
      when "\r" then break
      # Si l'utilisateur appuie sur 'q', on sort du programme
      when 'q' then exit
      # Gère l'appui sur les flèches
      when "\e" then keyboard_arrows
      end
      # Ré-affichage du menu actualisé à chaque itération de la boucle
      display_menu
    end
    # Retourne l'index de la sélection du joueur
    @selected
  end

  private

  def keyboard_arrows
    case $stdin.getch
    when '['
      case $stdin.getch
      # Si l'utilisateur appuie sur 'haut', on décrémente @selected de 1
      when 'A'
        @selected = @selected.zero? ? @selected : @selected - 1
      # Le contraire pour la flèche du bas
      when 'B'
        @selected = @selected == @actions.length - 1 ? @selected : @selected + 1
      end
    end
  end
end

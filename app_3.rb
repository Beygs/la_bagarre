# frozen_string_literal: true

require 'io/console'
require 'bundler'
Bundler.require

require_relative('./lib/game')
require_relative('./lib/player')
require_relative('./lib/human_player')
require_relative('./lib/weapon')
require_relative('./lib/weapons')
require_relative('./lib/menu')
require_relative('./lib/user_actions_menu')
require_relative('./lib/display')

system 'clear'

puts 'Salut, et bienvenue dans La Bagarre !'
puts "C'est quoi ton petit nom ?"

name = gets.chomp

puts 'Choisis le niveau de difficulté souhaité :'

difficulty = Menu.new([
                        'Enfant de 5 ans',
                        'Très facile',
                        'Facile',
                        'Moyen',
                        'Pas si simple mais un peu simple quand même en fait',
                        "Qu'est-ce que la simplicité ?",
                        'Difficile',
                        'Pro-Gamer',
                        "Je commence à être à court d'idées",
                        'Félix Gaudé',
                        'Gotaga',
                        'Impossible',
                        'Pffffffffff',
                        'Aléatoire',
                        'OSKOUR',
                        'Je passe beaucoup trop de temps sur ce projet...'
                      ])

settings = Menu::DIFFICULTY[difficulty.menu_choice]

load = Thread.new { Game.new(name, settings[0], settings[1]) }
Display.loading_screen
my_game = load.value
load.exit

while my_game.is_still_ongoing?
  my_game.menu

  my_game.enemies_attack

  my_game.new_players_in_sight
end

my_game.end

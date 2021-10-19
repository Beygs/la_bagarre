# frozen_string_literal: true

require 'io/console'
require 'bundler'
Bundler.require

require_relative('./lib/game')
require_relative('./lib/player')
require_relative('./lib/human_player')
require_relative('./lib/weapon')
require_relative('./lib/weapons')
require_relative('./lib/display')

player1 = Player.new('Josiane')
player2 = Player.new('José')

round = 1

while player1.life_points.positive? && player2.life_points.positive?
  system 'clear'

  puts "Voici l'état des joueurs :".center(IO.console.winsize[1])
  puts

  sleep 1

  puts player1.show_state
  puts
  sleep 1.5
  puts player2.show_state
  sleep 1.5

  system 'clear'

  puts "Round #{round}, c'est parti pour la bagarre !".center(IO.console.winsize[1])
  puts

  sleep 1

  player1.attacks(player2)
  puts
  sleep 3.5
  if player2.life_points.positive?
    player2.attacks(player1)
    sleep 3.5
  end

  round += 1
end

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

system 'clear'

puts "
------------------------------------
|Bienvenue dans la bagarre !       |
|C'est quoi ton nom de bagarreur ? |
------------------------------------
"

print '> '

player = HumanPlayer.new(gets.chomp)

enemies = [
  Player.new('Josiane'),
  Player.new('José')
]

while player.life_points.positive? && enemies.inject(0) { |s, e| s + e.life_points }.positive?
  player.show_state

  def menu_display(actions, selected, enemies)
    actions_display = actions.dup

    system 'clear'

    puts enemies[0].show_state, enemies[1].show_state

    puts 'Que veux-tu faire ?'
    puts

    actions_display[selected] = "\e[7m#{actions_display[selected]}\e[0m"
    puts(actions_display.map { |action| "#{action}\n" })
  end

  selected = 0

  actions = [
    'Chercher une meilleure arme',
    'Chercher à se soigner',
    "Attaquer #{enemies[0].name}",
    "Attaquer #{enemies[1].name}"
  ]

  menu_display(actions, selected, enemies)

  loop do
    case $stdin.getch
    when "\r"
      break
    when 'q'
      exit
    when "\e"
      case $stdin.getch
      when '['
        case $stdin.getch
        when 'A'
          selected = selected.zero? ? selected : selected - 1
        when 'B'
          selected = selected == 3 ? selected : selected + 1
        end
      end
    end
    menu_display(actions, selected, enemies)
  end

  system 'clear'

  case selected
  when 0 then player.search_weapon
  when 1 then player.search_health_pack
  else player.attacks(enemies[selected - 2])
  end

  sleep 2

  enemies.each do |enemy|
    next unless enemy.life_points.positive?

    puts
    enemy.attacks(player)
    sleep 2
  end

  puts
  puts 'Appuie sur Entrée pour continuer'

  loop do
    case $stdin.getch
    when "\r" then break
    when 'q' then exit
    end
  end
end

system 'clear'

if player.life_points.positive?
  puts 'Tu as gagné !'
else
  puts 'Tu as perdu... Sombre merde.'
end

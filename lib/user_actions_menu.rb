# frozen_string_literal: true

class UserActionsMenu < Menu
  def initialize(actions, enemies, user)
    super(actions)
    @enemies = enemies
    @user = user
    @win_width = IO.console.winsize[1]
  end

  def display_menu
    actions_display = @actions.dup

    system 'clear'

    puts "#{user_health_bar}\n\nEnnemis en vue :"

    @enemies.each { |e| puts enemy_health_bar(e) }

    puts
    puts 'Que veux-tu faire ?'.center(@win_width)
    puts

    actions_display[@selected] = "\e[7m#{actions_display[@selected]}\e[0m"
    puts(actions_display.map { |a| "#{a}\n" })
  end

  private

  def enemy_health_bar(enemy)
    life_points = enemy.life_points.to_f / enemy.max_health * 10
    bar = '█'
    case life_points
    when 7..10 then bar = "\e[32m#{bar}\e[0m"
    when 4..6 then bar = "\e[33m#{bar}\e[0m"
    when 1..3 then bar = "\e[31m#{bar}\e[0m"
    end
    "#{enemy.name.ljust(15)} #{bar * life_points}#{'▒' * (10 - life_points)}"
  end

  def user_health_bar
    life_points = @user.life_points / 10
    bar = '█'
    case life_points
    when 7..10 then bar = "\e[32m#{bar}\e[0m"
    when 4..6 then bar = "\e[33m#{bar}\e[0m"
    when 1..3 then bar = "\e[31m#{bar}\e[0m"
    end
    "#{"#{@user.name} #{@user.weapon.emoji}".ljust(15)}#{bar * life_points}#{'▒' * (10 - life_points)}"
  end
end

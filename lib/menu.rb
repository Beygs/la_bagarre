# frozen_string_literal: true

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

  def display_menu
    actions_display = @actions.dup

    system 'clear'

    puts 'Que veux-tu faire ?'.center(@win_width)
    puts

    actions_display[@selected] = "\e[7m#{actions_display[@selected]}\e[0m"
    puts actions_display.map { |a| "#{a}\n" }
  end

  def menu_choice
    display_menu
    loop do
      case $stdin.getch
      when "\r" then break
      when 'q' then exit
      when "\e" then keyboard_arrows
      end
      display_menu
    end
    @selected
  end

  private

  def keyboard_arrows
    case $stdin.getch
    when '['
      case $stdin.getch
      when 'A'
        @selected = @selected.zero? ? @selected : @selected - 1
      when 'B'
        @selected = @selected == @actions.length - 1 ? @selected : @selected + 1
      end
    end
  end
end

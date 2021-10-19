# frozen_string_literal: false

module Display
  def self.cool_text(string)
    string.chars.each do |c|
      sleep 0.005
      print c
    end
    puts
  end

  def self.loading_screen
    system 'clear'

    loading_bar = '▒' * 51

    50.times do |i|
      system 'clear'
      puts File.open('logo.txt').read
      puts "#{' ' * 12}#{loading_bar} #{i * 2} %"
      loading_bar.insert(0, '█')
      loading_bar.slice!(loading_bar.length - 1, loading_bar.length)
      sleep 0.05
    end
  end
end

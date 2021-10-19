# frozen_string_literal: false

# Module qui me permet de gérer plusieurs méthodes liées à l'affichage
module Display
  # Affichage de texte un caractère à la fois, le sleep permet de gérer la vitesse d'affichage
  def self.cool_text(string)
    string.chars.each do |c|
      sleep 0.005
      print c
    end
    puts
  end

  # Ecran de chargement de la version 3
  def self.loading_screen
    system 'clear'

    loading_bar = '▒' * 51

    50.times do |i|
      system 'clear'
      # Logo
      puts File.open('logo.txt').read
      # Barre de chargement
      puts "#{' ' * 12}#{loading_bar} #{i * 2} %"
      loading_bar.insert(0, '█')
      loading_bar.slice!(loading_bar.length - 1, loading_bar.length)
      sleep 0.05
    end
  end
end

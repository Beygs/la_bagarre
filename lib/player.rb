# frozen_string_literal: true

# Classe qui gère les joueurs
class Player
  attr_accessor :name, :life_points, :max_health

  def initialize(name, life_points = 10)
    @name = name
    # max_health me permet de gérer les barres de dommages quel que soit le nombre de points de vie
    @max_health = life_points
    @life_points = life_points
    @win_width = IO.console.winsize[1]
  end

  def show_state
    # Affichage de messages différents selon le pourcentage de vie
    life_points = @life_points.to_f / @max_health * 100
    case life_points
    when 90..100 then wonderful
    when 70..89 then cool
    when 50..69 then mouarf
    when 30..49 then bad
    when 1..29 then dying
    when 0 then rip
    end
  end

  def gets_damage(damage_level)
    @life_points = @life_points - damage_level <= 0 ? 0 : @life_points - damage_level
    puts
    Display.cool_text(show_state)
  end

  def attacks(player)
    Display.cool_text("#{@name} attaque #{player.name} !".center(@win_width))
    damage = compute_damage
    Display.cool_text("Il lui inflige #{damage} points de dégats ! Ca picote !".center(@win_width))
    player.gets_damage(damage)
  end

  def compute_damage
    rand(1..6)
  end

  private

  def wonderful
    "\e[36m#{@name}\e[0m possède \e[32m#{@life_points}\e[0m points de vie.
Il est frais comme un gardon !"
  end

  def cool
    "\e[36m#{@name}\e[0m possède \e[32m#{@life_points}\e[0m points de vie.
Il s'est juste cassé le poignet..."
  end

  def mouarf
    "Aïe, ça commence à piquer pour \e[36m#{@name}\e[0m.
Il a \e[33m#{@life_points}\e[0m points de vie le bougre."
  end

  def bad
    "Les forces commencent à manquer à \e[36m#{@name}\e[0m,
qui a \e[33m#{@life_points}\e[0m points de vie, mais plus l'usage de ses jambes..."
  end

  def dying
    "Bon, j'vais pas te mentir, \e[36m#{name}\e[0m vit probablement ses derniers instants.
Il a \e[31m#{@life_points}\e[0m points de vie, mais son corps, ou plutôt ce qu'il en reste,
n'est plus qu'une masse de chair informe..."
  end

  def rip
    "RIP \e[36m#{@name}\e[0m, press F to pay respect"
  end
end

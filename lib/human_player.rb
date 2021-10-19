# frozen_string_literal: true

class HumanPlayer < Player
  attr_accessor :weapon, :life_points

  def initialize(name)
    super(name)

    @life_points = 100
    @weapon = Weapons::WEAPONS[0]
  end

  def show_state
    state = ''
    case @life_points
    when 90..100 then state = wonderful
    when 70..89 then state = cool
    when 50..69 then state = mouarf
    when 30..49 then state = bad
    when 1..29 then state = dying
    when 0 then state = rip
    end
    "#{state}\nAh, et il a une arme #{@weapon.emoji} #{@weapon.name} de niveau #{@weapon.damage} !"
  end

  def compute_damage
    damage = super
    damage * @weapon.damage
  end

  def search_weapon
    new_weapon = Weapons::WEAPONS[rand(0..(Weapons::WEAPONS.length - 1))]
    Display.cool_text("Tu as trouvé '#{new_weapon.emoji} #{new_weapon.name}', une arme de niveau #{new_weapon.damage} !")
    weapon_choice(new_weapon)
  end

  def search_health_pack
    dice = rand(1..6)
    case dice
    when 1 then Display.cool_text("Tu n'as rien trouvé 😢")
    when 2..5
      Display.cool_text('Bravo ! Tu regagnes 50 points de vie !')
      @life_points = @life_points + 50 >= 100 ? 100 : @life_points + 50
    when 6
      Display.cool_text('Quelle chance ! Tu regagnes 80 points de vie !')
      @life_points = @life_points + 80 >= 100 ? 100 : @life_points + 80
    end
  end

  private

  def weapon_choice(new_weapon)
    if new_weapon.damage > @weapon.damage
      @weapon = new_weapon
      Display.cool_text('Elle a un niveau supérieur à celui de ton arme actuelle, tu la prends !')
    elsif new_weapon.damage == @weapon.damage
      @weapon = new_weapon
      Display.cool_text('Elle est équivalente à ton arme actuelle, mais tu la prends quand même...')
    else
      Display.cool_text("C'est de la merde.")
    end
  end
end

# frozen_string_literal: true

# Ce module permet de créer toutes les différentes armes disponibles
module Weapons
  WEAPONS = [
    Weapon.new('pichenette', '👈', 1),
    Weapon.new('ballon de baudruche', '🎈', 1),
    Weapon.new('confettis', '🎉', 1),
    Weapon.new("pouvoir de l'amour", '🖤', 1),
    Weapon.new('ticket', '🎫', 1),
    Weapon.new('donut', '🍩', 1),
    Weapon.new('banane', '🍌', 1),
    Weapon.new('claque', '👋', 1),
    Weapon.new('pile usagée', '🔋', 1),
    Weapon.new('coup de poing', '👊', 2),
    Weapon.new('clé de 12', '🔧', 2),
    Weapon.new('lampe torche', '🔦', 2),
    Weapon.new('bougie', '🕯', 2),
    Weapon.new('cigarette', '🚬', 2),
    Weapon.new('stylo', '🖋', 2),
    Weapon.new('punaise', '📌', 2),
    Weapon.new('marteau', '🔨', 3),
    Weapon.new('appel à un ami', '📞', 3),
    Weapon.new('paire de ciseaux', '✂️', 3),
    Weapon.new('cadeau piégé', '🎁', 3),
    Weapon.new('gros muscles', '💪', 3),
    Weapon.new('parapluie', '🌂', 3),
    Weapon.new('bidon de pétrole', '🛢', 4),
    Weapon.new('pioche', '⛏', 4),
    Weapon.new('couteau de cuisine', '🔪', 4),
    Weapon.new('prise électrique', '🔌', 4),
    Weapon.new('chanter faux', '🎤', 4),
    Weapon.new('pistolet', '🔫', 5),
    Weapon.new('feu', '🔥', 5),
    Weapon.new('scorpion', '🦂', 5),
    Weapon.new('poule maléfique', '🐔', 5),
    Weapon.new('dino', '🦖', 6),
    Weapon.new('foudre divine', '🌩', 6),
    Weapon.new('la mort en personne', '💀', 6)
  ].freeze
end

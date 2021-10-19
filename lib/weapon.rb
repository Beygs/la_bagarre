# frozen_string_literal: true

class Weapon
  attr_accessor :name, :emoji, :damage

  def initialize(name, emoji, damage)
    @name = name
    @emoji = emoji
    @damage = damage
  end
end

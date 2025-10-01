SMODS.Joker {
  key = 'sacrificial_lamb',
  config = {
    extra = {
      mult_mod = 3,
      mult = 0
    }
  },
  rarity = 1,
  pos = { x = 5, y = 0 },
  atlas = 'jokers_atlas',
  cost = 6,
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  soul_pos = nil,

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.mult_mod,
        card.ability.extra.mult,
      }
    }
  end,

  calculate = function(self, card, context)
    local count = PB_UTIL.count_destroyed_things(context)
    -- Gains mult when any cards are destroyed. Each card destroyed provides the specified mult_mod
    if not context.blueprint and count > 0
    -- Make sure that this joker isn't being removed
    and not (context.paperback and context.paperback.destroyed_joker and card == context.paperback.destroyed_joker)
    then
      card.ability.extra.mult = card.ability.extra.mult + count * card.ability.extra.mult_mod

      return {
        message = localize {
          type = 'variable',
          key = 'a_mult',
          vars = { count * card.ability.extra.mult_mod }
        },
        colour = G.C.MULT
      }
    end

    -- Gives the mult when scoring
    if context.joker_main and card.ability.extra.mult > 0 then
      return {
        mult = card.ability.extra.mult
      }
    end
  end,
}

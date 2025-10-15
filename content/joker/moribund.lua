SMODS.Joker {
  key = 'moribund',
  config = {
    extra = {
      a_mult = 5,
      mult = 0,
    }
  },
  rarity = 2,
  pos = { x = 0, y = 5 },
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
        card.ability.extra.a_mult,
        card.ability.extra.mult,
      }
    }
  end,

  calculate = function(self, card, context)
    -- Prevent Blueprint or Brainstorm from copying these effects
    if not context.blueprint then
      if context.end_of_round and context.main_eval then
        -- If blind not cleared, double current mult
        if to_big(G.GAME.chips - G.GAME.blind.chips) < to_big(0) then
          card.ability.extra.mult = card.ability.extra.mult * 2

          return {
            message = localize('paperback_doubled_ex'),
            colour = G.C.MULT,
            card = card
          }
        elseif G.GAME.current_round.hands_left == 0 then
          -- If blind cleared and 0 hands left, upgrade joker
          card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.a_mult

          return {
            message = localize('k_upgrade_ex'),
            card = card,
            colour = G.C.MULT,
          }
        end
      end
    end

    -- Give the mult during scoring
    if context.joker_main then
      if card.ability.extra.mult ~= 0 then
        return {
          mult = card.ability.extra.mult,
        }
      end
    end
  end,

  joker_display_def = function(JokerDisplay)
    return {
      text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" }
      },
      text_config = { colour = G.C.MULT },
    }
  end,
}

SMODS.Joker {
  key = 'grand_strategy',
  config = {
    extra = {
      xMult = 4,
      card_modifiers_required = 7,
    }
  },
  rarity = 3,
  pos = { x = 5, y = 5 },
  atlas = "jokers_atlas",
  cost = 8,
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  soul_pos = nil,

  loc_vars = function(self, info_queue, card)
    local unique_specials = PB_UTIL.special_cards_in_deck(true, false)

    return {
      vars = {
        card.ability.extra.xMult,
        card.ability.extra.card_modifiers_required,
        unique_specials
      }
    }
  end,

  calculate = function(self, card, context)
    if context.joker_main then
      if PB_UTIL.special_cards_in_deck(true, false) >= card.ability.extra.card_modifiers_required then
        return {
          x_mult = card.ability.extra.xMult,
          card = card
        }
      end
    end
  end,

  joker_display_def = function(JokerDisplay)
    return {
      text = {
        {
          border_nodes = {
            { text = "X" },
            { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }
          }
        }
      },
      reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "unique_specials" },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "card_modifiers_required" },
        { text = ")" },
      },
      calc_function = function(card)
        card.joker_display_values.unique_specials = PB_UTIL.special_cards_in_deck(true, false)
        card.joker_display_values.x_mult =
            card.joker_display_values.unique_specials >= card.ability.extra.card_modifiers_required
            and card.ability.extra.xMult or 1
      end
    }
  end,
}

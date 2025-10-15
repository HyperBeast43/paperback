SMODS.Joker {
  key = "heretical_joker",
  effect = "Suit Mult",
  config = {
    extra = {
      s_mult = 5,
      suit = 'paperback_Stars'
    }
  },
  rarity = 1,
  pos = { x = 5, y = 8 },
  atlas = "jokers_atlas",
  cost = 5,
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  paperback = {
    requires_stars = true
  },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.s_mult,
      }
    }
  end,

  -- Copied from JokerDisplay
  joker_display_def = function(JokerDisplay)
    return {
      text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
      },
      text_config = { colour = G.C.MULT },
      reminder_text = {
        { text = "(" },
        {
          ref_table = "card.joker_display_values",
          ref_value = "localized_text",
          colour = lighten(loc_colour(G.P_CENTERS["j_paperback_heretical_joker"].config.extra.suit:lower()), 0.35)
        },
        { text = ")" },
      },
      calc_function = function(card)
        local mult = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
          for _, scoring_card in pairs(scoring_hand) do
            if scoring_card:is_suit(card.ability.extra.suit) then
              mult = mult +
                  card.ability.extra.s_mult *
                  JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
            end
          end
        end
        card.joker_display_values.mult = mult
        card.joker_display_values.localized_text = localize(card.ability.extra.suit, 'suits_plural')
      end
    }
  end,
}

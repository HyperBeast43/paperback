PB_UTIL.EGO_Gift {
  key = 'thrill',
  config = {
    sin = 'gluttony',
    xmult = 1,
    a_xmult = 0.5,
  },
  atlas = 'ego_gift_atlas',
  pos = { x = 3, y = 0 },

  ego_loc_vars = function(self, info_queue, card)
    return {
      card.ability.a_xmult,
      card.ability.xmult
    }
  end,

  ego_gift_calc = function(self, card, context)
    if context.pre_discard and G.GAME.current_round.hands_played <= 0 then
      card.ability.xmult = card.ability.xmult + card.ability.a_xmult
      return {
        message = localize {
          type = 'variable',
          key = 'a_xmult',
          vars = { card.ability.xmult }
        },
        colour = G.C.MULT
      }
    end

    if context.joker_main then
      if G.GAME.current_round.hands_played <= 0 then
        return {
          xmult = card.ability.xmult
        }
      end
    end
  end,
}

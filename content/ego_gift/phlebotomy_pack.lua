PB_UTIL.EGO_Gift {
  key = 'phlebotomy_pack',
  config = {
    sin = 'wrath',
    a_hand = 1,
  },
  atlas = 'ego_gift_atlas',
  pos = { x = 0, y = 1 },


  ego_gift_calc = function(self, card, context)
    if context.setting_blind then
      ease_hands_played(card.ability.extra.a_hand)
    end
  end,

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = PB_UTIL.sin_tooltip(card.ability.sin)

    return {
      vars = {
        card.ability.a_hand
      }
    }
  end,
}

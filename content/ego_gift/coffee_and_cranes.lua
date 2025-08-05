PB_UTIL.EGO_Gift {
  key = 'coffee_and_cranes',
  config = {
    sin = 'lust',
    a_int = 1,
    int_max = 25,
    threshold = 3,
    int_mod = 0,
    previous_int = 0,
  },
  atlas = 'ego_gift_atlas',
  pos = { x = 1, y = 0 },



  ego_loc_vars = function(self, info_queue, card)
    card.ability.int_mod = math.max(0,
      math.min(25,
        card.ability.a_int * math.floor(G.GAME.dollars / card.ability.threshold)))
    return {
      card.ability.a_int,
      card.ability.threshold,
      card.ability.int_max,
      card.ability.int_mod
    }
  end,
  ego_gift_calc = function(self, card, context)
    if context.end_of_round and context.cardarea == G.consumeables then
      G.GAME.interest_amount = G.GAME.interest_amount - card.ability.previous_int

      card.ability.int_mod = math.max(0,
        math.min(25,
          card.ability.a_int * math.floor(G.GAME.dollars / card.ability.threshold)))

      G.GAME.interest_amount = G.GAME.interest_amount + card.ability.int_mod

      card.ability.previous_int = card.ability.int_mod
    end
  end,

  remove_from_deck = function(self, card, from_debuff)
    G.GAME.interest_amount = G.GAME.interest_amount - card.ability.previous_int
  end
}

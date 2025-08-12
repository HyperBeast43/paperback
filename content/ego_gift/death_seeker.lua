PB_UTIL.EGO_Gift {
  key = 'death_seeker',
  config = {
    sin = 'gluttony',
  },
  atlas = 'ego_gift_atlas',
  pos = { x = 3, y = 2 },

  ego_gift_calc = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if SMODS.get_enhancements(context.other_card) and not SMODS.has_no_rank(context.other_card) then
        return {
          mult = context.other_card.base.nominal
        }
      end
    end
  end,
}

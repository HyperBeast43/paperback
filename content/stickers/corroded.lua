SMODS.Sticker {
  key = 'corroded',
  atlas = 'stickers_atlas',
  pos = { x = 2, y = 0 },
  badge_colour = G.C.PAPERBACK_EGO_GIFT_RED,
  should_apply = false,
  rate = 0,
  config = {
    paperback_corrode_tally = 3
  },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        (card.ability or {}).paperback_corrode_tally or self.config.paperback_corrode_tally
      }
    }
  end,

  draw = function(self, card)
    -- Don't draw the shine over the sticker
    G.shared_stickers[self.key].role.draw_major = card
    G.shared_stickers[self.key]:draw_shader('dissolve', nil, nil, nil, card.children.center)
  end,


}
-- Hook end_round to destroy Jokers and Consumables with this sticker
local end_round_ref = end_round
function end_round()
  for _, v in ipairs(G.consumeables and G.consumeables.cards or {}) do
    if v.ability.paperback_corroded then
      if v.ability.paperback_corrode_tally > 1 then
        v.ability.paperback_corrode_tally = v.ability.paperback_corrode_tally - 1
        SMODS.calculate_effect({
          message = localize {
            type = 'variable',
            key = 'paperback_a_round_minus',
            vars = { 1 }
          },
          colour = G.C.FILTER,
          instant = true
        }, card)
      else
        PB_UTIL.SIN_DEBUFF(v.ability.sin)
        if v.ability.sin ~= 'wrath' then
          SMODS.destroy_cards(v)
        end
      end
    end
  end

  return end_round_ref()
end

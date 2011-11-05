#coding: utf-8

class Player
  def initialize(args)
    @box    = args[:box]
    @bat_at = args[:bat_at]
    @hit    = args[:hit]
  end

  def batting_average
    return nil   if @box == 0
    return 0.000 if @bat_at == 0
    (@hit.to_f /  @bat_at.to_f).round(3)
  end
end


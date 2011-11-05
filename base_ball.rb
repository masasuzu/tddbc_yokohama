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

  def formated_string
    return '1.00' if self.batting_average == 1.0
    return '.000' if self.batting_average == 0.0
    return '----' if self.batting_average == nil
    sprintf ".%d",  (self.batting_average * 1000)
#'.' + (self.batting_average * 1000).truncate.to_s
  end
end

class PlayerList
  def initialize(players)
    @players = players
  end

  attr_reader :players

  def sort_by_average
    @players.sort do |a, b|
      if a.batting_average == nil then
        1
      elsif b.batting_average == nil then
        -1
      else
        b.batting_average <=> a.batting_average
      end
    end
  end
end


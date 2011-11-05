#coding: utf-8
require 'rspec'
require './base_ball'

describe Player do
  it "打席数、打数、安打数を受け取り打率を計算できること" do
    Player.new({ box: 515, bat_at: 454, hit: 135 }).batting_average.should == 0.297
    Player.new({ box: 461, bat_at: 392, hit: 83  }).batting_average.should == 0.212
    Player.new({ box: 11,  bat_at: 11,  hit: 11  }).batting_average.should == 1.000
    Player.new({ box: 15,  bat_at: 11,  hit: 11  }).batting_average.should == 1.000
  end

  it "打席数が０の場合、打率を計算しないいこと" do
    Player.new({ box: 0, bat_at: 0, hit: 0 }).batting_average.should == nil
  end

  it "打席数が０ではなく、打数が0の場合「0.000」と計算すること" do
    Player.new({ box: 5, bat_at: 0, hit: 0 }).batting_average.should == 0.000 
  end

  it '四捨五入' do
    1.1234.round(3).should == 1.123
  end
end

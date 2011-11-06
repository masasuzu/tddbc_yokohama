#coding: utf-8
require 'rspec'
require './base_ball'

describe Player do
  context '打席数：515, 打数：454、ヒット：135の時' do
    before do
      @player = Player.new({ box: 515, bat_at: 454, hit: 135 })
    end
    it "打席数、打数、安打数を受け取り打率を計算できること" do
      @player.batting_average.should == 0.297
    end
    it '整形した打率を文字列で表示できること' do
      @player.formated_string.should == '.297'
    end
  end

  context '打席数：461, 打数：392、ヒット：83の時' do
    before do
      @player = Player.new({ box: 461, bat_at: 392, hit: 83  })
    end
    it "打席数、打数、安打数を受け取り打率を計算できること" do
      @player.batting_average.should == 0.212
    end
    it '整形した打率を文字列で表示できること' do
      @player.formated_string.should == '.212'
    end
  end

  context '打率が10割の時' do
    before do
      @player = Player.new({ box: 1, bat_at: 1, hit: 1  })
    end
    it '整形した打率を文字列で表示できること' do
      @player.formated_string.should == '1.00'
    end
  end


  context '打席数が0の時' do
    before do
      @player = Player.new({ box: 0, bat_at: 1, hit: 1  })
    end

    it "打率を計算しないいこと" do
      @player.batting_average.should == nil
    end

    it '打率を計算しない場合は、「----」と表示すること' do
      @player.formated_string.should == '----'
    end
  end

  context '打率が0割のとき' do
    before do
      @player = Player.new({ box: 5, bat_at: 0, hit: 0  })
    end

    it "打席数が０ではなく、打数が0の場合「0.000」と計算すること" do
      @player.batting_average.should == 0.000
    end

    it '整形した打率を文字列で表示できること' do
      @player.formated_string.should == '.000'
    end
  end

  it '四捨五入' do
    1.1234.round(3).should == 1.123
  end
end

describe PlayerList do
  context '元々打率順がソートされている場合' do
    before do
      akiyama = Player.new({ box: 515, bat_at: 454, hit: 135 }) #0.297
      ito     = Player.new({ box: 461, bat_at: 392, hit: 83  }) #0.212
      @player_list = PlayerList.new([akiyama, ito])
    end
    it '選手のリストを作成できること' do
      @player_list.players[0].batting_average.should == 0.297
      @player_list.players[1].batting_average.should == 0.212
    end
    it '打率の順位を計算できること' do
      sorted_list = @player_list.sort_by_average
      sorted_list[0].batting_average.should == 0.297
      sorted_list[1].batting_average.should == 0.212
    end
  end

  context '元々打率順がソートされていない場合' do
    before do
      akiyama = Player.new({ box: 515, bat_at: 454, hit: 135 }) #0.297
      ito     = Player.new({ box: 461, bat_at: 392, hit: 83  }) #0.212
      @player_list = PlayerList.new([ito, akiyama])
    end
    it '選手のリストを作成できること' do
      @player_list.players[0].batting_average.should == 0.212
      @player_list.players[1].batting_average.should == 0.297
    end
    it '打率の順位を計算できること' do
      sorted_list = @player_list.sort_by_average
      sorted_list[0].batting_average.should == 0.297
      sorted_list[1].batting_average.should == 0.212
    end
  end

  context '打席数0の人と打率0割の人を比較する場合' do
    before do
      akiyama = Player.new({ box: 5, bat_at: 0, hit: 0})
      ito     = Player.new({ box: 0, bat_at: 0, hit: 0})
      nagano  = Player.new({ box: 578, bat_at: 519, hit: 164}) #0.316
      @player_list = PlayerList.new([akiyama, ito, nagano])
    end
    it '選手のリストを作成できること' do
      @player_list.players[0].batting_average.should == 0.000
      @player_list.players[1].batting_average.should == nil
      @player_list.players[2].batting_average.should == 0.316
    end
    it '打率の順位を計算できること' do
      sorted_list = @player_list.sort_by_average
      sorted_list[0].batting_average.should == 0.316
      sorted_list[1].batting_average.should == 0.000
      sorted_list[2].batting_average.should == nil
    end
  end
end

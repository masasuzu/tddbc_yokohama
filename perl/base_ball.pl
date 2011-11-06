use strict;
use warnings;

package Player;

sub new {
    my ($class, $args) = @_;
    bless $args, $class;
}

sub batting_average {
    my $self = $_[0];
    $self->{box} == 0 ?  undef :
        $self->{bat_at}  == 0 ? 0.000 :
        int ($self->{hit} / $self->{bat_at} * 10**3) / 10**3;
}

use feature "switch";
sub format_string {
    my $self = $_[0];
    given ($self->batting_average) {
        when (undef) {
            return '----';
        }
        when (1.000) {
            return '1.00';
        }
        when (0.00) {
            return '.000';
        }
        default {
            return sprintf '.%d', $self->batting_average * 1000 ;
        }
    }
}

package PlayerList;

sub new {
    my ($class, $players) = @_;
    bless +{ players => $players }, $class;
}

sub sort_by_average {
    my $self = $_[0];
    [ sort { 
        $b->batting_average <=> $a->batting_average
    } @{ $self->{players} }];
}

package main;
use Test::More;

my $ito     = Player->new(+{box=> 3, bat_at => 3, hit => 1});
my $sasaki  = Player->new(+{box=> 3, bat_at => 3, hit => 3});
my $hayashi = Player->new(+{box=> 3, bat_at => 0, hit => 0});
my $mine    = Player->new(+{box=> 0, bat_at => 0, hit => 0});

subtest '打率の計算ができること' => sub {
    is($ito->batting_average     => 0.333);
    is($sasaki->batting_average  => 1.000);
    is($hayashi->batting_average => 0.000);
    is($mine->batting_average    => undef);
    done_testing();
};

subtest '選手の打率を整形できること' => sub {
    is($ito->format_string     => '.333');
    is($sasaki->format_string  => '1.00');
    is($hayashi->format_string => '.000');
    is($mine->format_string    => '----');
    done_testing();
};

subtest '選手の順位を取得できること:できること' => sub {
#my $player_list = PlayerList->new([ $sasaki, $hayashi, $ito, $mine ]);
    my $player_list = PlayerList->new([ $ito, $sasaki,]);
    is($player_list->{players}->[0]->batting_average => 0.333);
    is($player_list->{players}->[1]->batting_average => 1.000);
    my $sorted_list = $player_list->sort_by_average;
    is($sorted_list->[0]->batting_average => 1.000);
    is($sorted_list->[1]->batting_average => 0.333);
    done_testing();
};

done_testing();


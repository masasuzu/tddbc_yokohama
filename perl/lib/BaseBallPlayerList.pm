package BaseBallPlayerList;
use strict;
use warnings;

sub new {
    my ($class, $players) = @_;
    bless +{ players => $players }, $class;
}

sub sort_by_average {
    my $self = $_[0];
    [ sort { 
        if (defined $a->batting_average && defined $b->batting_average) {
            $b->batting_average <=> $a->batting_average
        }
        elsif (defined $a->batting_average) {
            -1;
        }
        else {
            1;
        }
    } @{ $self->{players} }];
}

1;


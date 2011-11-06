package PlayerList;
use strict;
use warnings;

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

1;


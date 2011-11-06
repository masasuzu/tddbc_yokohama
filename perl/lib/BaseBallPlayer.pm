package BaseBallPlayer;
use strict;
use warnings;
use feature "switch";

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

sub format_string {
    my $self = $_[0];
    given ($self->batting_average) {
        when (undef) { return '----'; }
        when (1.000) { return '1.00'; }
        when (0.00)  { return '.000'; }
        default      { return sprintf '.%d', $self->batting_average * 1000 ; }
    }
}


1;


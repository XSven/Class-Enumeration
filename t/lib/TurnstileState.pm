use strict;
use warnings;

package TurnstileState;

# On purpose do not use Class::Enumeration::Builder
use parent 'Class::Enumeration';

our @Values = do { ## no critic ( ProhibitPackageVars )
  my $ordinal = 0;
  map { __PACKAGE__->new( $ordinal++, $_ ) } qw( Locked Unlocked )
};

1

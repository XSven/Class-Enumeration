use strict;
use warnings;

package TurnstileState;

use parent 'Class::Enumeration';

our @Values = do { ## no critic ( ProhibitPackageVars )
  my $ordinal = 0;
  map { __PACKAGE__->new( $_, $ordinal++ ) } qw( Locked Unlocked )
};

1

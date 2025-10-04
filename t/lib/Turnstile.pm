use strict;
use warnings;

package Turnstile;

use parent 'Class::Enumeration';

our @Values = do { ## no critic ( ProhibitPackageVars )
  my $ordinal = 0;
  map { __PACKAGE__->new( $_, $ordinal++ ) } qw( Unlocked Locked )
};

1

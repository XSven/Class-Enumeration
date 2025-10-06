use strict;
use warnings;

package ToastStatus;

use Class::Enumeration::Builder;

our @Values = do { ## no critic ( ProhibitPackageVars )
  my $ordinal = 0;
  map { __PACKAGE__->new( $ordinal++, $_ ) } qw( bread toasting toast burnt )
};

1

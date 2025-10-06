use strict;
use warnings;

package Class::Enumeration::Builder;

use parent ();

sub import {
  shift;

  my $enum_class = caller;
  parent->import( -inheritor => $enum_class, 'Class::Enumeration' );
  no strict 'refs'; ## no critic ( ProhibitNoStrict )
  *{ "$enum_class\::Values" } = [
    do {
      my $ordinal = 0;
      map { $enum_class->new( $ordinal++, $_ ) } @_
    }
  ]
}

1

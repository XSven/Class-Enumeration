use strict;
use warnings;

package Class::Enumeration::Builder;

use parent ();

sub import {
  shift;

  # $class == enum class
  my $class = caller;

  parent->import( -inheritor => $class, 'Class::Enumeration' );

  my @values;
  my $ordinal = 0;
  # https://metacpan.org/pod/Class::Enum#Advanced-usage
  # Check if custom attributes were provided
  if ( ref $_[ 1 ] eq 'HASH' ) {
    # TODO: getters for custom attributes have to be setup in enum class
    while ( my ( $name, $attributes ) = splice @_, 0, 2 ) {
      push @values, $class->new( $ordinal++, $name, $attributes )
    }
  } else {
    @values = map { $class->new( $ordinal++, $_ ) } @_
  }

  {
    no strict 'refs'; ## no critic ( ProhibitNoStrict )
    *{ "$class\::Values" } = \@values;
  }
}

1

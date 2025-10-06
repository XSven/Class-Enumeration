use strict;
use warnings;

package CoffeeSize;

# On purpose do not use Class::Enumeration::Builder
use parent 'Class::Enumeration';

# https://metacpan.org/pod/Class::Enum#Advanced-usage
our @Values; ## no critic ( ProhibitPackageVars )
my $ordinal = 0;
my @tmp     = ( BIG => { ounces => 8 }, HUGE => { ounces => 10 }, OVERWHELMING => { ounces => 16 } );
while ( my ( $name, $attributes ) = splice @tmp, 0, 2 ) {
  push @Values, __PACKAGE__->new( $ordinal++, $name, $attributes )
}

sub ounces {
  my ( $self ) = @_;

  $self->{ ounces }
}

1

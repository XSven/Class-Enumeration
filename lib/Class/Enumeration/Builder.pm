# Prefer numeric version for backwards compatibility
BEGIN { require 5.010_001 }; ## no critic ( RequireUseStrict, RequireUseWarnings )
use strict;
use warnings;

package Class::Enumeration::Builder;

$Class::Enumeration::Builder::VERSION = 'v1.0.0';

use subs '_compare_attributes';

use Carp               qw( croak );
use Class::Enumeration ();

sub import {
  shift;

  # $class == enum class
  my $class = caller;

  # Now start building the enum class
  {
    no strict 'refs'; ## no critic ( ProhibitNoStrict )
    push @{ "$class\::ISA" }, 'Class::Enumeration'
  }

  my @values;
  my $ordinal = 0;
  # https://metacpan.org/pod/Class::Enum#Advanced-usage
  # Check if custom attributes were provided
  if ( ref $_[ 1 ] eq 'HASH' ) {
    my ( $reference_name, $reference_attributes ) = @_[ 0 .. 1 ];
    # TODO: getters for custom attributes have to be setup in enum class
    while ( my ( $name, $attributes ) = splice @_, 0, 2 ) {
      croak "'$reference_name' enum and '$name' enum have different custom attributes, stopped"
        unless _compare_attributes $reference_attributes, $attributes;
      push @values, $class->new( $ordinal++, $name, $attributes )
    }
  } else {
    @values = map { $class->new( $ordinal++, $_ ) } @_
  }

  {
    no strict 'refs'; ## no critic ( ProhibitNoStrict )
    no warnings 'once';
    @{ "$class\::Values" } = @values
  }
}

sub _compare_attributes ( $$ ) {
  my ( $reference_attributes, $attributes ) = @_;

  # Compare 2 sets of names
  my @reference_attributes = sort keys %$reference_attributes;
  my @attributes           = sort keys %$attributes;

  return unless @reference_attributes == @attributes;
  for ( my $i = 0 ; $i < @reference_attributes ; $i++ ) {
    return if $reference_attributes[ $i ] ne $attributes[ $i ]
  }
  1
}

1

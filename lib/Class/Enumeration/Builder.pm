# Prefer numeric version for backwards compatibility
BEGIN { require 5.010_001 }; ## no critic ( RequireUseStrict, RequireUseWarnings )
use strict;
use warnings;

package Class::Enumeration::Builder;

$Class::Enumeration::Builder::VERSION = 'v1.0.0';

use subs '_is_equal';

use Carp               qw( croak );
use Class::Enumeration ();
use Sub::Util          qw( set_subname );

sub import {
  shift;

  my $options = ref $_[ 0 ] eq 'HASH' ? shift : {};

  # $class == enum class
  my $class = exists $options->{ class } ? delete $options->{ class } : caller;

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
    # Build list (@values) of enum object
    while ( my ( $name, $attributes ) = splice @_, 0, 2 ) {
      croak "'$reference_name' enum and '$name' enum have different custom attributes, stopped"
        unless _is_equal $reference_attributes, $attributes;
      push @values, $class->_new( $ordinal++, $name, $attributes )
    }
    # Build getters for custom attributes
    for my $getter ( keys %$reference_attributes ) {
      no strict 'refs'; ## no critic ( ProhibitNoStrict )
      *{ "$class\::$getter" } = set_subname "$class\::$getter" => sub { my ( $self ) = @_; $self->{ $getter } }
    }
  } else {
    # Build list (@values) of enum object
    @values = map { $class->_new( $ordinal++, $_ ) } @_
  }

  {
    no strict 'refs'; ## no critic ( ProhibitNoStrict )
    no warnings 'once';
    # Inject list of enum objects
    @{ "$class\::Values" } = @values
  }

  $class
}

# Compare 2 sets of hash keys
sub _is_equal ( $$ ) {
  my ( $reference_attributes, $attributes ) = @_;

  my @reference_attributes = keys %$reference_attributes;
  return unless @reference_attributes == keys %$attributes;
  for ( @reference_attributes ) {
    return unless exists $attributes->{ $_ }
  }
  1
}

1

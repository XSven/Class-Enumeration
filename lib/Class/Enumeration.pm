# prefer numeric version for backwards compatibility
BEGIN { require 5.010_001 }; ## no critic ( RequireUseStrict, RequireUseWarnings )
use strict;
use warnings;

package Class::Enumeration;

$Class::Enumeration::VERSION = 'v1.0.0';

use overload
  '""'     => 'as_string',
  '=='     => '_is_identical_to',
  '!='     => sub { !&_is_identical_to }, ## no critic ( ProhibitAmpersandSigils )
  fallback => 0;

use Carp         ();
use Scalar::Util ();

# $self == enum object
# $class == enum class

sub new {
  my ( $class, $name, $ordinal ) = @_;

  bless { name => $name, ordinal => $ordinal }, $class
}

sub name {
  my ( $self ) = @_;

  $self->{ name }
}

sub ordinal {
  my ( $self ) = @_;

  $self->{ ordinal }
}

sub value_of {
  my ( $class, $name ) = @_;

  my ( $self ) = grep { $_->name eq $name } $class->values;
  defined $self ? $self : Carp::croak "No enum object defined for name '$name', stopped"
}

sub values { ## no critic ( ProhibitBuiltinHomonyms )
  my ( $class ) = @_;

  no strict 'refs'; ## no critic ( ProhibitNoStrict )
  sort { $a->ordinal <=> $b->ordinal } @{ *{ "$class\::Values" }{ ARRAY } }
}

sub names {
  my ( $class ) = @_;

  map { $_->name } $class->values
}

sub as_string {
  my ( $self ) = @_;

  $self->name
}

sub _is_identical_to {
  my ( $self, $object, $swapFlag ) = @_;

  Scalar::Util::refaddr $self == Scalar::Util::refaddr $object;
}

1

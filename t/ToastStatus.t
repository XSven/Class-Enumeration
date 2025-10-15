## no critic (ProhibitMagicNumbers)

use strict;
use warnings;

use Test::Lib;
use Test::More import => [ qw( BAIL_OUT cmp_ok is_deeply isa_ok note plan require_ok subtest ) ], tests => 3;
use Test::Fatal qw( dies_ok );

my $class;

BEGIN {
  $class = 'ToastStatus';
  require_ok $class or BAIL_OUT "Cannot load class '$class'!";
}

subtest 'Class method invocations' => sub {
  plan tests => 18;

  for my $self ( $class->values ) {
    note my $name = $self->name;
    cmp_ok "$self", 'eq', $name, 'Check default stringification';
    isa_ok $self, $class;
    isa_ok $self, 'Class::Enumeration';
    cmp_ok $self, '==', $class->value_of( $self->name ), 'Get enum object reference by name'
  }

  is_deeply [ $class->names ], [ qw( bread toasting toast burnt ) ], 'Get names of enum objects';

  dies_ok { $class->value_of( 'initial' ) } 'No such enum object for the given name'
};

subtest 'Access enum attributes' => sub {
  plan tests => 8;

  my $self = $class->value_of( 'bread' );
  cmp_ok $self->name,    'eq', 'bread', 'Get name';
  cmp_ok $self->ordinal, '==', 0,       'Get ordinal';

  $self = $class->value_of( 'toasting' );
  cmp_ok $self->name,    'eq', 'toasting', 'Get name';
  cmp_ok $self->ordinal, '==', 1,          'Get ordinal';

  $self = $class->value_of( 'toast' );
  cmp_ok $self->name,    'eq', 'toast', 'Get name';
  cmp_ok $self->ordinal, '==', 2,       'Get ordinal';

  $self = $class->value_of( 'burnt' );
  cmp_ok $self->name,    'eq', 'burnt', 'Get name';
  cmp_ok $self->ordinal, '==', 3,       'Get ordinal'
}

## no critic (ProhibitMagicNumbers)

use strict;
use warnings;

use Test::Lib;
use Test::More import => [ qw( BAIL_OUT cmp_ok is_deeply isa_ok note plan subtest use_ok ) ], tests => 3;
use Test::Fatal qw( dies_ok );

my $class;

BEGIN {
  $class = 'TurnstileState';
  use_ok( $class, qw( :all ) ) or BAIL_OUT "Cannot load class '$class'!";
}

subtest 'Class method invocations' => sub {
  plan tests => 10;

  for my $enum ( $class->values ) {
    note my $name = $enum->name;
    cmp_ok "$enum", 'eq', $name, 'Check default stringification';
    isa_ok $enum, $class;
    isa_ok $enum, 'Class::Enumeration';
    cmp_ok $enum, '==', $class->value_of( $enum->name ), 'Get enum object reference by name'
  }

  is_deeply [ $class->names ], [ qw( Locked Unlocked ) ], 'Get names of enum objects';

  dies_ok { $class->value_of( 'Initial' ) } 'No such enum object for the given name'
};

subtest 'Access enum fields' => sub {
  plan tests => 4;

  my $enum = $class->value_of( 'Locked' );
  cmp_ok $enum->name,    'eq', 'Locked', 'Get name';
  cmp_ok $enum->ordinal, '==', 0,        'Get ordinal';

  $enum = $class->value_of( 'Unlocked' );
  cmp_ok $enum->name,    'eq', 'Unlocked', 'Get name';
  cmp_ok $enum->ordinal, '==', 1,          'Get ordinal'
}

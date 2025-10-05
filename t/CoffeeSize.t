## no critic (ProhibitMagicNumbers)

use strict;
use warnings;

use Test::Lib;
use Test::More import => [ qw( BAIL_OUT cmp_ok is_deeply isa_ok note plan subtest use_ok ) ], tests => 3;
use Test::Fatal qw( dies_ok );

my $class;

BEGIN {
  $class = 'CoffeeSize';
  use_ok $class or BAIL_OUT "Cannot load class '$class'!";
}

subtest 'Class method invocations' => sub {
  plan tests => 14;

  for my $enum ( $class->values ) {
    note my $name = $enum->name;
    cmp_ok "$enum", 'eq', $name, 'Check default stringification';
    isa_ok $enum, $class;
    isa_ok $enum, 'Class::Enumeration';
    cmp_ok $enum, '==', $class->value_of( $enum->name ), 'Get enum object reference by name'
  }

  is_deeply [ $class->names ], [ qw( BIG HUGE OVERWHELMING ) ], 'Get names of enum objects';

  dies_ok { $class->value_of( 'INITIAL' ) } 'No such enum object for the given name'
};

subtest 'Access enum attributes' => sub {
  plan tests => 6;

  my $enum = $class->value_of( 'BIG' );
  cmp_ok $enum->name,    'eq', 'BIG', 'Get name';
  cmp_ok $enum->ordinal, '==', 0,     'Get ordinal';
  cmp_ok $enum->ounces,  '==', 8,     'Get ounces';

  $enum = $class->value_of( 'HUGE' );
  cmp_ok $enum->name,    'eq', 'HUGE', 'Get name';
  cmp_ok $enum->ordinal, '==', 1,      'Get ordinal';
  cmp_ok $enum->ounces,  '==', 10,     'Get ounces'
}

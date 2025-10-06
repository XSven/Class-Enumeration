## no critic (ProhibitMagicNumbers)

use strict;
use warnings;

use Test::Lib;
use Test::More import => [ qw( BAIL_OUT cmp_ok is_deeply isa_ok note plan subtest use_ok ) ], tests => 3;
use Test::Fatal qw( dies_ok );

my $class;

BEGIN {
  $class = 'ToastStatus';
  use_ok $class or BAIL_OUT "Cannot load class '$class'!";
}

subtest 'Class method invocations' => sub {
  plan tests => 18;

  for my $enum ( $class->values ) {
    note my $name = $enum->name;
    cmp_ok "$enum", 'eq', $name, 'Check default stringification';
    isa_ok $enum, $class;
    isa_ok $enum, 'Class::Enumeration';
    cmp_ok $enum, '==', $class->value_of( $enum->name ), 'Get enum object reference by name'
  }

  is_deeply [ $class->names ], [ qw( bread toasting toast burnt ) ], 'Get names of enum objects';

  dies_ok { $class->value_of( 'initial' ) } 'No such enum object for the given name'
};

subtest 'Access enum attributes' => sub {
  plan tests => 8;

  my $enum = $class->value_of( 'bread' );
  cmp_ok $enum->name,    'eq', 'bread', 'Get name';
  cmp_ok $enum->ordinal, '==', 0,       'Get ordinal';

  $enum = $class->value_of( 'toasting' );
  cmp_ok $enum->name,    'eq', 'toasting', 'Get name';
  cmp_ok $enum->ordinal, '==', 1,          'Get ordinal';

  $enum = $class->value_of( 'toast' );
  cmp_ok $enum->name,    'eq', 'toast', 'Get name';
  cmp_ok $enum->ordinal, '==', 2,       'Get ordinal';

  $enum = $class->value_of( 'burnt' );
  cmp_ok $enum->name,    'eq', 'burnt', 'Get name';
  cmp_ok $enum->ordinal, '==', 3,       'Get ordinal'
}

use strict;
use warnings;

use Test::More import => [ qw( BAIL_OUT use_ok ) ], tests => 6;
use Test::API import => [ qw( public_ok ) ];
use Test::Fatal qw( dies_ok lives_ok );

my $class;

BEGIN {
  $class = 'Class::Enumeration';
  use_ok $class or BAIL_OUT "Cannot load class '$class'!"
}

public_ok $class, qw( new name ordinal value_of values names as_string );

dies_ok { $class->new( 'Locked', 0, [] ) } 'Wrong optional attributes data structure';

for ( qw( name ordinal ) ) {
  dies_ok { $class->new( 'Locked', 0, { $_ => undef } ) } "Overriding $_ attribute is forbidden"
}

lives_ok { $class->new( 'BIG', 0, { ounces => 8 } ) } 'Provide valid optional attributes data structure'

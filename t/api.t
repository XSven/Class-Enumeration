use strict;
use warnings;

use Test::More import => [ qw( BAIL_OUT use_ok ) ], tests => 2;
use Test::API import => [ qw( public_ok ) ];

my $class;

BEGIN {
  $class = 'Class::Enumeration';
  use_ok $class or BAIL_OUT "Cannot load class '$class'!"
}

public_ok $class, qw( new name ordinal value_of values names as_string )

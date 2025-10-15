use strict;
use warnings;

use Test::More import => [ qw( BAIL_OUT require_ok ) ], tests => 4;
use Test::Fatal qw( dies_ok lives_ok );

my $class;

BEGIN {
  $class = 'Class::Enumeration::Builder';
  require_ok $class or BAIL_OUT "Cannot load class '$class'!"
}

dies_ok { $class->import( A => {}, B => { foo => 2 } ) } 'Different number of custom attributes';

dies_ok { $class->import( A => { foo => 1 }, B => { bar => 2 } ) } 'Different names of custom attributes';

lives_ok { $class->import( A => { foo => 1 }, B => { foo => 2 } ) } 'Same names of custom attributes';

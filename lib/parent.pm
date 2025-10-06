use strict;
use warnings;

package parent;

our $VERSION = '0.244';

sub import {
  shift;

  shift if my $norequire = @_ && $_[ 0 ] eq -norequire;
  my $inheritor = @_ && $_[ 0 ] eq -inheritor
    ? do {
    shift;
    shift;
    }
    : caller;

  unless ( $norequire ) {
    for ( my @filename = @_ ) {
      local @_; ## no critic ( RequireInitializationForLocalVars )
      s{::|'}{/}g;
      $_ .= '.pm';
      require
    }
  }

  {
    no strict 'refs'; ## no critic ( ProhibitNoStrict )
    push @{ $inheritor . '::ISA' }, @_
  }
}

1

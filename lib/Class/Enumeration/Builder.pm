use strict;
use warnings;

package Class::Enumeration::Builder;

use parent ();

sub import { parent->import( -inheritor => scalar caller, 'Class::Enumeration' ) }

1

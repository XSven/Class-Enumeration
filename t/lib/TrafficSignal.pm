use strict;
use warnings;

package TrafficSignal;

use Class::Enumeration::Builder (
  GREEN  => { action => 'go' },
  ORANGE => { action => 'slow down' },
  RED    => { action => 'stop' }
);

sub action {
  my ( $self ) = @_;

  $self->{ action }
}

1

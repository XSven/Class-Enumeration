use strict;
use warnings;

package TrafficSignal;

use subs 'as_string';

use Class::Enumeration::Builder (
  GREEN  => { action => 'go' },
  ORANGE => { action => 'slow down' },
  RED    => { action => 'stop' }
);

sub action {
  my ( $self ) = @_;

  $self->{ action }
}

sub as_string {
  my ( $self ) = @_;

  $self->action . ' if ' . $self->name
}

1

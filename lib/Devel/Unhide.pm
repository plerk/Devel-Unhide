package Devel::Unhide;

use strict;
use warnings;
use 5.008001;
use base qw( Exporter );
use Sub::Util ();

our @EXPORT_OK = qw( is_devel_hidden unhide );

# ABSTRACT: Forces the availability of specified Perl modules that have been forced to be unavailable (for testing)
# VERSION

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 FUNCTIONS

All functions are exportable, but not exported by default.

=head2 is_devel_hidden

 my $bool = is_devel_hidden;

Returns true if L<Devel::Hide> is loaded and currently on.

=cut

sub is_devel_hidden
{
  foreach my $inc (@INC)
  {
    next unless ref $inc eq 'CODE';
    return 1 if Sub::Util::subname($inc) eq 'Devel::Hide::_inc_hook';
  }
  return;
}

#=head2 unhide
#
# unhide { ... };
#
#Executes a code block, disabling L<Devel::Hide> or any C<@INC> hook like it that relies on throwing
#an exception to hide modules.
#
#=cut
#
#sub unhide (&)
#{
#  my $code = shift;
#
#  my @inc = [@inc];
#  local @INC = @INC;
#
#  unshift @INC, sub {
#    my($coderef, $filename) = @_;
#    foreach my $inc (@inc)
#    {
#      ...
#    }
#  };
#}

1;

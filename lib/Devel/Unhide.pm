package Devel::Unhide;

use strict;
use warnings;
use 5.008001;
use base qw( Exporter );

our @EXPORT_OK = qw( is_devel_hidden unhide );

# ABSTRACT: Forces the availability of specified Perl modules that have been forced to be unavailable (for testing)
# VERSION

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 FUNCTIONS

All functions are exportable, but not exported by default.

=head2 is_devel_hidden

 my $bool = is_devel_hidden;

Returns true if L<Devel::Hide>, or L<Test::Without::Module> is loaded and currently active.  Other
similar modules may be added in the future as needed.

=cut

sub is_devel_hidden
{
  require Sub::Util;
  foreach my $inc (@INC)
  {
    next unless ref $inc eq 'CODE';
    return 1 if Sub::Util::subname($inc) =~ /^(Devel::Hide::_inc_hook|Test::Without::Module::fake_module)$/;
  }
  return;
}

=head2 unhide

 unhide { ... };

Executes a code block, disabling L<Devel::Hide> or any C<@INC> hook like it that relies on throwing
an exception to hide modules.

=cut

sub unhide (&)
{
  my $code = shift;

  local @INC = map {
    ref $_ eq 'CODE'
      ? do {
        my $old = $_;
        sub {
          my(undef, $filename) = @_;
          $DB::single = 1;
          local $@;
          my @res = eval { $old->($old, $filename) };
          return if $@;
          @res;
        };
      } : $_;
  } @INC;

  $code->();
}

1;

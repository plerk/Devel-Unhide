# Devel::Unhide [![Build Status](https://secure.travis-ci.org/plicease/Devel-Unhide.png)](http://travis-ci.org/plicease/Devel-Unhide)

Forces the availability of specified Perl modules that have been forced to be unavailable (for testing)

# SYNOPSIS

# DESCRIPTION

# FUNCTIONS

All functions are exportable, but not exported by default.

## is\_devel\_hidden

    my $bool = is_devel_hidden;

Returns true if [Devel::Hide](https://metacpan.org/pod/Devel::Hide), or [Test::Without::Module](https://metacpan.org/pod/Test::Without::Module) is loaded and currently active.  Other
similar modules may be added in the future as needed.

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2019 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

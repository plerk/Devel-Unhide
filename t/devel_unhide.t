use Test2::V0 -no_srand => 1;
use Devel::Unhide qw( is_devel_hidden unhide );
use Sub::Util qw( subname );
use lib 'corpus/lib';

subtest 'is_devel_hidden' => sub {

  # if Devel::Hide is loaded via PERL5OPT or similar, then this
  # subtest will not works.
  skip_all 'test requires that Devel::Hide is not already loaded'
    if $INC{'Devel/Hide.pm'};

  subtest 'Test::Without::Module' => sub {

    is(is_devel_hidden, F());

    require Test::Without::Module;
    Test::Without::Module->import;

    is(is_devel_hidden, T());

    # undo T::W::M
    @INC = grep { ref $_ eq 'CODE' ? subname($_) ne 'Test::Without::Module::fake_module' : 1 } @INC;

    is(is_devel_hidden, F());

  };

  subtest 'Devel::Hide' => sub {

    is(is_devel_hidden, F());

    require Devel::Hide;

    is(is_devel_hidden, T());

  };

};

subtest 'unhide' => sub {

  $Devel::Hide::VERBOSE =
  $Devel::Hide::VERBOSE = 0;
  Devel::Hide->import('Foo::Bar::Baz');

  eval { require Foo::Bar::Baz };
  isnt $@, '';

  unhide {

    delete $INC{'Foo/Bar/Baz.pm'};

    is is_devel_hidden, F();

    eval { require Foo::Bar::Baz };
    is $@, '';

    is $INC{'Foo/Bar/Baz.pm'}, T();

    is(Foo::Bar::Baz->answer, 42);

  };

};

done_testing

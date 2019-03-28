use Test2::V0 -no_srand => 1;
use Devel::Unhide qw( is_devel_hidden );

subtest 'is_devel_hidden' => sub {

  skip_all 'test requires that Devel::Hide is not already loaded'
    if $INC{'Devel/Hide.pm'};

  is(is_devel_hidden, F());

  require Devel::Hide;

  is(is_devel_hidden, T());

};

done_testing

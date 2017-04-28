package t::Base; {

=encoding utf8
=head1 NAME
    Different utilites 
=cut

use strict;
use warnings;

use Mojo::Base -strict;
use Test::More;
use Test::Mojo;
use Test::Mojo::Session;
use File::Temp;

use t::Base;

my $t = t::Base::get_test_mojo();

$t->get_ok('/')->status_is(200);
$t->get_ok('/cabinet')->status_is(200);

done_testing();

# END OF PACKAGE
};

1;

__END__
=head1 AUTHOR
    M.Nurullaev <maksud.nurullaev@gmail.com>
=cut

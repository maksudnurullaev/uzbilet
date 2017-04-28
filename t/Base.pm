package t::Base; {

=encoding utf8
=head1 NAME
    Base utilities for tests
=cut

use strict;
use warnings;

use Mojo::Base -strict;
use Test::More;
use Test::Mojo;
use Test::Mojo::Session;
use File::Temp qw/ mktemp /;
use Db;

sub get_test_mojo{ Test::Mojo->new('Uzbilet'); };
sub get_test_mojo_session{ Test::Mojo::Session->new('Uzbilet'); };

sub get_test_db{
    my $test_mojo = get_test_mojo();
    my $test_db   = Db->new( $test_mojo, mktemp('tempDbFileXXXXXX') );
    ok( $test_db->get_db_connection(), 'Test db connection!' );
    ok( $test_db->is_valid, 'Check database' );
    return( $test_db );
}

# END OF PACKAGE
};

1;

__END__
=head1 AUTHOR
    M.Nurullaev <maksud.nurullaev@gmail.com>
=cut

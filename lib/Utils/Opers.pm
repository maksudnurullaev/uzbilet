package Utils::Opers; {

=encoding utf8
=head1 NAME
    Different initial values
=cut

use 5.012000;
use strict;
use warnings;
use utf8;

use Db;

sub get_many{
    my $self = shift;
    my $dbh = Db->new($self);
    return $dbh->get_objects({ name => ['operator']});

};

sub get_1{
    my ($self,$id) = @_;
    my $dbh = Db->new($self);
    return $dbh->get_objects({ name => ['operator'], id => [$id]});

};

# END OF PACKAGE
};

1;

__END__

=head1 AUTHOR

    M.Nurullaev <maksud.nurullaev@gmail.com>

=cut

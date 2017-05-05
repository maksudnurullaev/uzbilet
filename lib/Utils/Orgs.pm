package Utils::Orgs; {

=encoding utf8
=head1 NAME
    Different initial values
=cut

use 5.012000;
use strict;
use warnings;
use utf8;

use Db;

sub get_orgs{
    my $self = shift;
    my $dbh = Db->new($self);
    return $dbh->get_objects({ name => ['organization']});

};

sub get_org{
    my ($self,$id) = @_;
    my $dbh = Db->new($self);
    return $dbh->get_objects({ name => ['organization'], id => [$id]});

};

# END OF PACKAGE
};

1;

__END__

=head1 AUTHOR

    M.Nurullaev <maksud.nurullaev@gmail.com>

=cut

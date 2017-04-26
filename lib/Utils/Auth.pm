package Utils::Auth; {

=encoding utf8
=head1 NAME
    Different initial values
=cut

use 5.012000;
use strict;
use warnings;
use utf8;

sub set_login_session{
    my ($self,$login) = @_;
    for my $key (keys %{$login} ){
        $self->session->{$key} = $login->{$key};
    }
};

sub unset_login_session{ shift->session(expires => 1); };

sub is_authorized{
    my $self = shift;
    return( $self->session('client_role') ? 1 : 0 );
};

# END OF PACKAGE
};

1;

__END__

=head1 AUTHOR

    M.Nurullaev <maksud.nurullaev@gmail.com>

=cut

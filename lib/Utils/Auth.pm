package Utils::Auth; {

=encoding utf8
=head1 NAME
    Different initial values
=cut

use 5.012000;
use strict;
use warnings;
use utf8;
use Crypt::SaltedHash;

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

sub salted_password{
    my $password = Utils::trim(shift); # password - generates salted password
    my $salt     = Utils::trim(shift); # salt     - just validate password and salt
    if(defined($password)){
        if(defined($salt)){
            return(scalar(Crypt::SaltedHash->validate($salt, $password)));
        }
        my $csh = Crypt::SaltedHash->new(algorithm => 'SHA-512');
        $csh->add($password);
        return($csh->generate);
    }
    return(undef);
};


# END OF PACKAGE
};

1;

__END__

=head1 AUTHOR

    M.Nurullaev <maksud.nurullaev@gmail.com>

=cut

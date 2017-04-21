package Uzbilet::Controller::Cabinet; {

use Mojo::Base 'Mojolicious::Controller';

use Utils::Calculate ;
use Utils::Validators ;
use Utils::Auth;
use Data::Dumper;

sub start{
    my $self = shift;
    return if $self->req->method ne 'POST' ;

    if( Utils::Validators::login_stage1_validate_fields($self) && 
        (my $login = Utils::Validators::login_stage2_check_account($self)) ) {
        warn Dumper $login;
        Utils::Auth::set_login_session($self, $login);
    }
};

sub logout{
    my $self = shift;
    Utils::Auth::unset_login_session($self);
    $self->redirect_to('/cabinet');
};

};

1;

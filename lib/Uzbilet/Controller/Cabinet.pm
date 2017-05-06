package Uzbilet::Controller::Cabinet; {

use Mojo::Base 'Mojolicious::Controller';

use Utils::Calculate ;
use Utils::Validators ;
use Utils::Auth;
use Data::Dumper;

sub start{
    my $self = shift;
    if( Utils::Auth::is_authorized($self) ){
        $self->redirect_to('/cabinet/authorized');
        return;
    }
    return if $self->req->method ne 'POST' ;

    if( Utils::Validators::login_stage1_validate_fields($self) && 
        (my $login = Utils::Validators::login_stage2_check_account($self)) ) {
        Utils::Auth::set_login_session($self, $login);
        $self->redirect_to('/cabinet/authorized');
    } else {
		$self->stash(internalError => 1);
    }
};

sub logout{
    my $self = shift;
    Utils::Auth::unset_login_session($self);
    $self->redirect_to('/cabinet');
};

sub authorized{
    my $self = shift;
    $self->redirect_to('/cabinet/start') if !Utils::Auth::is_authorized($self) ; 
};


};
1;

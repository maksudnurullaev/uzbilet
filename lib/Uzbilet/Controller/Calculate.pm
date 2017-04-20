package SumovNet::Controller::Calculate; {

use Mojo::Base 'Mojolicious::Controller';

use Utils::Calculate ;
use Utils::Validators ;
use Data::Dumper;

sub start{
    my $self = shift;
    
    Utils::Validators::calculate_start($self);
};

sub selected{
    my $self = shift;
    return if $self->req->method ne 'POST' ;

    if( my $result = Utils::Validators::calculate_selected($self) ){
        $self->app->log->warn("TODO add new record 'user info' with credit wishes");
        warn Dumper $result;
    }
};

};

1;


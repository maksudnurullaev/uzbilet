package SumovNet::Controller::Initial; {
use Mojo::Base 'Mojolicious::Controller';

use Utils::Languages;


sub language{
    my $self = shift;
    
    Utils::Languages::current($self,$self->param('payload'));
    $self->redirect_to('/');
};

1;

};

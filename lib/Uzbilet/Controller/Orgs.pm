package Uzbilet::Controller::Orgs; {
use Mojo::Base 'Mojolicious::Controller';

use Data::Dumper;

sub add{
    my $self = shift;
    return if $self->req->method ne 'POST' ;

    my $validation = $self->validation;
    $validation->required('name')->size(4,35);
    $validation->required('org_type');
    $validation->required('city');
    $validation->optional('description','trim');

    if( $validation->has_error ){
        say for @{$validation->failed};
		$self->stash(formWithError => 1);
        return;
    }

	say Dumper $self->req->params->to_hash ;
};

1;

};

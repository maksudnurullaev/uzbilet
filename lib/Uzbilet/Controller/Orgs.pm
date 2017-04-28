package Uzbilet::Controller::Orgs; {
use Mojo::Base 'Mojolicious::Controller';

use Data::Dumper;
use Db;
use Utils::Auth;

sub start{
    my $self = shift;
	return if Utils::Auth::has_role($self,'admin');

};

sub add{
    my $self = shift;
	return if Utils::Auth::has_role($self,'admin');
    return if $self->req->method ne 'POST' ;

    my $validation = $self->validation;
    $validation->required('name')->size(4,35);
    $validation->required('org_type');
    $validation->required('city');
    $validation->optional('description','trim');

    if( $validation->has_error ){
        #TODO remove late - say for @{$validation->failed};
		$self->stash(formWithError => 1);
        return;
    }

	my $dbh = Db->new($self);
	
	my $new_record = $self->req->params->to_hash;
	$new_record->{object_name} = 'organization';
    
	if( $dbh->insert($new_record) ){
		$self->redirect_to("/orgs/");
	} else {
		$self->stash(internalError => 1);
	}
};

1;

};

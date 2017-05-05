package Uzbilet::Controller::Orgs; {
use Mojo::Base 'Mojolicious::Controller';

use Data::Dumper;
use Utils::Orgs;
use Utils::Auth;

sub start{
    my $self = shift;
	return if !Utils::Auth::has_role($self,'admin');

    $self->stash(orgs => Utils::Orgs::get_orgs($self));
};

sub add{
    my $self = shift;
	return if !Utils::Auth::has_role($self,'admin');
    return if $self->req->method ne 'POST' ;

    my $validation = $self->validation;
    $validation->required('name')->size(4,35);
    $validation->required('org_type');
    $validation->required('city');
    $validation->optional('description','trim');

    if( $validation->has_error ){
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
  
sub edit{
    my $self = shift;
	return if !Utils::Auth::has_role($self,'admin');
    if( $self->req->method ne 'POST' ){
        $self->stash(org => Utils::Orgs::get_org($self, $self->param('payload')));
        return;
    };

    my $validation = $self->validation;
    $validation->required('name')->size(4,35);
    $validation->required('org_type');
    $validation->required('city');
    $validation->optional('description','trim');

    if( $validation->has_error ){
		$self->stash(formWithError => 1);
        return;
    }

	my $dbh = Db->new($self);
	
	my $record = $self->req->params->to_hash;
	$record->{object_name} = 'organization';
    
	if( $dbh->update($record) ){
		$self->stash(actionSuccess => 1);
	} else {
		$self->stash(internalError => 1);
	}
    $self->stash(org => Utils::Orgs::get_org($self, $self->param('payload')));
};

1;

};

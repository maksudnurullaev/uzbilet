package Uzbilet::Controller::Opers; {
use Mojo::Base 'Mojolicious::Controller';

use Data::Dumper;
use Utils::Orgs;
use Utils::Auth;
use Utils::Opers;

sub start{
    my $self = shift;
	return if !Utils::Auth::has_role($self,'admin');

    $self->stash(opers => Utils::Opers::get_many($self));
};

sub add{
    my $self = shift;
	return if !Utils::Auth::has_role($self,'admin');
    return if $self->req->method ne 'POST' ;

    my $validation = $self->validation;
    $validation->required('name')->size(4,35);
    $validation->required('phone')->like(q/^\d{9}$/);;
    $validation->required('password','trim')->size(4,35)->equal_to('password2');
    $validation->required('password2')->equal_to('password');

    if( $validation->has_error ){
        for my $_fail_name ($validation->failed){
		    $self->stash("error_field_$_fail_name" => 1);
        }
        return;
    }

	my $dbh = Db->new($self);
	
	my $new_record = $self->req->params->to_hash;
	$new_record->{object_name} = 'operator';
   
	if( $dbh->insert($new_record) ){
		$self->redirect_to("/opers/");
	} else {
		$self->stash(internalError => 1);
	}
};
  
sub edit{
    my $self = shift;
	return if !Utils::Auth::has_role($self,'admin');
    if( $self->req->method ne 'POST' ){
        $self->stash(object => Utils::Opers::get_1($self, $self->param('payload')));
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

package Utils::Orgs; {

=encoding utf8
=head1 NAME
    Utils for Orgs
=cut

use 5.012000;
use strict;
use warnings;
use utf8;

use Db;

sub get_many{
    my $self = shift;
    my $dbh = Db->new($self);
    return $dbh->get_objects({ name => ['organization']});
};

sub get_1{
    my ($self,$id) = @_;
    my $dbh = Db->new($self);
    return $dbh->get_objects({ name => ['organization'], id => [$id]});

};

sub has_error{
    my $self = shift;

    my $validation = $self->validation;
    $validation->required('name')->size(4,35);
    $validation->required('org_type');
    $validation->required('city');
    $validation->optional('description','trim');

    $self->stash(formWithError => 1) if $validation->has_error ;
    return $validation->has_error;
};

sub add{
    my $self = shift;

	my $dbh = Db->new($self);
	my $new_record = $self->req->params->to_hash;
	$new_record->{object_name} = 'organization';
	if( $dbh->insert($new_record) ){
		$self->redirect_to("/orgs/");
        return(0);
	} else {
		$self->stash(internalError => 1);
        return(1);
	}
};

sub update{
    my $self = shift;

   	my $dbh = Db->new($self);
    my $record = $self->req->params->to_hash;
    $record->{object_name} = 'organization';
   
   	if( $dbh->update($record) ){
    	$self->stash(actionSuccess => 1);
        return(0);
    } else {
   		$self->stash(internalError => 1);
        return(1);
   	}
};

# END OF PACKAGE
};

1;

__END__

=head1 AUTHOR

    M.Nurullaev <maksud.nurullaev@gmail.com>

=cut

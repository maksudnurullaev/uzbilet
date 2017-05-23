package Utils::Opers; {

=encoding utf8
=head1 NAME
    Utils for Opers
=cut

use 5.012000;
use strict;
use warnings;
use utf8;

use Utils::Auth; 
use Db;
use Data::Dumper;

sub get_many{
    my $self = shift;
    my $dbh = Db->new($self);
    return $dbh->get_objects({ name => ['operator']});

};

sub get_1{
    my ($self,$id) = @_;
    my $dbh = Db->new($self);
    return $dbh->get_objects({ name => ['operator'], id => [$id]});

};

sub has_error{
    my $self = shift;
    my $type = shift || 'new';

    my $validation = $self->validation;
    $validation->required('name')->size(4,35);
    $validation->required('phone')->like(q/^\d{9}$/);

    if( $type eq 'new' || ($type eq 'update' &&  $self->req->param('password')) ){
        $validation->required('password','trim')->size(4,35)->equal_to('password2');
        $validation->required('password2')->equal_to('password');
    }

    if( $validation->has_error ){
        $self->stash(formWithError => 1);
        for my $_fail_name ($validation->failed){
		    $self->stash("error_field_$_fail_name" => 1);
        }
    }
    return $validation->has_error;
};

sub create{
    my $self = shift;
    my $type = shift || 'new' ;
    my $record = $self->req->params->to_hash;
	$record->{object_name} = 'operator';
    # Encrypt password
    $record->{password} = Utils::Auth::salted_password($record->{password});
    # Remove unused password2
    delete $record->{password2};
    # Add blocked record
    $record->{blocked} = exists($record->{blocked})?'on':'off';

	my $dbh = Db->new($self);
    if( $type eq 'new' && $dbh->insert($record) ){
		$self->redirect_to("/opers/");
    } elsif ( $type eq 'update' && $dbh->update($record) ) {
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

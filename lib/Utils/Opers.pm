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
    my $is_password_mandatory = shift;
    $is_password_mandatory = 1 if !defined($is_password_mandatory);

    my $validation = $self->validation;
    $validation->required('name')->size(4,35);
    $validation->required('phone')->like(q/^\d{9}$/);

    warn "is_password_mandatory: $is_password_mandatory";
    warn "Test 2: " . $self->req->param('password');

    if( $is_password_mandatory || 
            (!$is_password_mandatory &&  $self->req->param('password')) ){
        warn "is_password_mandatory 2: $is_password_mandatory";
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

sub add{
    my $self = shift;

	my $new_record = $self->req->params->to_hash;
	$new_record->{object_name} = 'operator';
    # Encrypt password
    $new_record->{password} = Utils::Auth::salted_password($new_record->{password});
    # Remove unused password2
    delete $new_record->{password2};

	my $dbh = Db->new($self);
	if( $dbh->insert($new_record) ){
		$self->redirect_to("/opers/");
	} else {
		$self->stash(internalError => 1);
	}
};

sub update{
    my $self = shift;

    my $new_record = $self->req->params->to_hash;
	$new_record->{object_name} = 'operator';
    # Encrypt password if neccessary
    if( $self->validation->param('password') ){
        $new_record->{password} = Utils::Auth::salted_password($new_record->{password}) if $self->validation->param('password');
    } else {
        delete $new_record->{password};
    }
    # Remove unused password2
    delete $new_record->{password2};
   
   	my $dbh = Db->new($self);
   	if( $dbh->update($new_record) ){
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

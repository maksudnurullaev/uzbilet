package Uzbilet::Controller::Opers; {
use Mojo::Base 'Mojolicious::Controller';

use Data::Dumper;
use Utils::Auth;
use Utils::Opers;

sub start{
    my $self = shift;
	return if !Utils::Auth::has_role($self,'admin') ;

    $self->stash(objects => Utils::Opers::get_many($self));
};

sub add{
    my $self = shift;
	return if !Utils::Auth::has_role($self,'admin');

    Utils::Opers::create($self) if $self->req->method eq 'POST' && !Utils::Opers::has_error($self);
};
  
sub edit{
    my $self = shift;
    return if !Utils::Auth::has_role($self,'admin');

    Utils::Opers::create($self,'update') if $self->req->method eq 'POST' && !Utils::Opers::has_error($self,'update');
    $self->stash(object => Utils::Opers::get_1($self, $self->param('payload')));
};

1;

};

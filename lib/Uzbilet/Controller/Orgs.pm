package Uzbilet::Controller::Orgs; {
use Mojo::Base 'Mojolicious::Controller';

use Data::Dumper;
use Utils::Orgs;
use Utils::Auth;

sub start{
    my $self = shift;
	return if !Utils::Auth::has_role($self,'admin');

    $self->stash(orgs => Utils::Orgs::get_many($self));
};

sub add{
    my $self = shift;
	return if !Utils::Auth::has_role($self,'admin');

    Utils::Orgs::create($self) if $self->req->method eq 'POST' && !Utils::Orgs::has_error($self);
};
  
sub edit{
    my $self = shift;
    return if !Utils::Auth::has_role($self,'admin');

    Utils::Orgs::create($self,'update') if $self->req->method eq 'POST' && !Utils::Orgs::has_error($self);
    $self->stash(object => Utils::Orgs::get_1($self, $self->param('payload')));
};

1;

};

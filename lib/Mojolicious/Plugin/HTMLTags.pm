package Mojolicious::Plugin::HTMLTags; {

=encoding utf8
=head1 NAME
    Add additional useful html tags for in web page templates
=head1 USAGE
    See documentation to certain module

=cut

use 5.012000;
use strict;
use warnings;
use utf8;
use base 'Mojolicious::Plugin';
use Utils::Languages;
use Utils::Calculate; 
use Utils::Currency;

use ML;

our $VERSION        = 'v0.0.1b';

sub register {
    my ($self,$app) = @_;
    $app->helper( ml  => sub { ML::process_string (@_); } ); 
    $app->helper( mlm => sub { ML::process_block (@_); } ); 

    $app->helper( languages_current => sub { Utils::Languages::current(@_); } );
    $app->helper( calculate_credit  => sub { Utils::Calculate::credit(@_); } );

    $app->helper( currency_format => sub { Utils::Currency::format (@_); } );
};

};

1;

__END__

=head1 AUTHOR

    M.Nurullaev <maksud.nurullaev@gmail.com>

=cut

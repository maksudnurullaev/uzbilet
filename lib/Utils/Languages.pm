package Utils::Languages; {

=encoding utf8
=head1 NAME
    Different utilites 
=cut

use 5.012000;
use strict;
use warnings;
use utf8;

our $DEFAULT_LANG   = 'rus';
our $DEFAULT_LANGS  = {'eng' => 3 , 'rus' => 1, 'uzb' => 2};

sub current{
    my $self = shift;
    my $lang = shift;

    $self->session->{'lang'} = $lang if $lang && exists( $DEFAULT_LANGS->{$lang} )  ;
    return $self->session->{'lang'} if exists($self->session->{'lang'}) ;
    return($DEFAULT_LANG);
};

# END OF PACKAGE
};

1;

__END__

=head1 AUTHOR

    M.Nurullaev <maksud.nurullaev@gmail.com>

=cut

package Utils::Currency; {

=encoding utf8
=head1 NAME
    Currency formating
=cut

use 5.012000;
use strict;
use warnings;
use utf8;

use Locale::Currency::Format ;

sub format{
    my $self   = shift;
    my $amount = shift;

    Locale::Currency::Format::currency_set('USD','#.###,## ', FMT_COMMON); 
    return Locale::Currency::Format::currency_format('USD',$amount, FMT_COMMON);
} ;

# END OF PACKAGE
};

1;

__END__

=head1 AUTHOR

    M.Nurullaev <maksud.nurullaev@gmail.com>

=cut

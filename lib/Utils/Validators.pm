package Utils::Validators; {

=encoding utf8
=head1 NAME
    Different validators
=cut

use 5.012000;
use strict;
use warnings;
use utf8;
use Data::Dumper ;

use Utils::Credits;

sub creditMonths{
    my $months = shift;
    $months =~ s/[\D\s]//g ;
    return undef if !$months;
    return $months if $months && $months >= $Utils::Credits::MinMonths && $months <= $Utils::Credits::MaxMonths ;
    return undef ;
};

sub creditAmount{
    my $creditAmount = shift;
    return undef if !$creditAmount ;
    $creditAmount =~ s/[\D\s]//g ;
    return $creditAmount if $creditAmount && $creditAmount >= $Utils::Credits::MinAmount && $creditAmount <= $Utils::Credits::MaxAmount;
    return undef;
};

sub stringVal{
    my $string = $_[0];
    if(defined($string) && $string){
        $string =~ s/^\s+|\s+$//g;
        return($string);
    }
    return(undef);
};


sub calculate_start{
    my $self = shift;
    
    my $creditAmount = $self->param('creditAmount');
    if( $creditAmount = Utils::Validators::creditAmount($creditAmount) ){
        $self->stash( {creditAmount => $creditAmount} );
        return( $creditAmount );
    }
    $self->stash( {formWithError => 1} ) if $self->param('creditAmount') ;
    return undef;
};

sub calculate_selected{
    my $self = shift;

    my $rph = $self->req->params->to_hash;

    # stage I
    if (    !creditAmount($rph->{creditAmount}) 
         || !creditMonths($rph->{months}) ){
        $self->app->log->warn("Invalid creditAmount($rph->{creditAmount}) OR months($rph->{months})") ;
        $self->stash( {formWithError => 1} ) ;
        return (undef);
    } else { # stage II
        $rph->{client_name} = stringVal($rph->{client_name});
        $rph->{client_phone} =~ s/[\D\s]//g ;
        if( !$rph->{client_name}  ||
            !$rph->{client_phone} ||
            $rph->{client_phone} !~ /^\d{9}$/ ) {

            $self->stash( {formWithError => 1} ) ;
            return (undef);
        }
    }
    return ($rph);
};

# END OF PACKAGE
};

1;

__END__

=head1 AUTHOR

    M.Nurullaev <maksud.nurullaev@gmail.com>

=cut

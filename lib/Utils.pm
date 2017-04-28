package Utils; {

=encoding utf8
=head1 NAME
    Different utilites 
=cut

use 5.012000;
use strict;
use warnings;
use utf8;
use Cwd;
use Time::Piece;
use Data::UUID;
use File::Spec;
use File::Path qw(make_path);
use Locale::Currency::Format;
use Data::Dumper;


sub trim{
    my $string = $_[0];
    if(defined($string) && $string){
        $string =~ s/^\s+|\s+$//g;
        return($string);
    }
    return(undef);
};

sub get_uuid{
    my $ug = new Data::UUID;
    my $uuid = $ug->create;
    my @result = split('-',$ug->to_string($uuid));
    return($result[0]);
};

sub get_date_uuid{
    my $result= Time::Piece->new->strftime('%Y.%m.%d %T ');
    return($result . get_uuid());
};

sub if_defined{
    my ($self,$key) = @_;
    return(undef) if !defined($self->stash($key));
    return(scalar(@{$self->stash($key)})) if ref($self->stash($key)) eq "ARRAY";
    return(scalar(keys(%{$self->stash($key)}))) if ref($self->stash($key)) eq "HASH"; 
    return($self->stash($key));
};

sub get_date{
    my $self = shift;
    my $format = shift || '%Y.%m.%d';
    return Time::Piece->new->strftime($format);
};

sub validate_date{
    my $date = shift;
    return(undef) if !$date || $date !~ /^\d{4}\.\d{2}\.\d{2}$/;
    my $format = shift || '%Y.%m.%d';
    my $result;
    eval{ $result = Time::Piece->strptime($date,$format); };
    return(undef) if $@;
    return($result->strftime($format));
};

sub currency_format1{
    my $self   = shift;
    my $amount = shift;
    my $ccode  = shift || 'UZB';
    if( $ccode eq 'UZB' ){
        Locale::Currency::Format::currency_set('USD','#.###,## ', FMT_COMMON);
    }
    return Locale::Currency::Format::currency_format('USD',$amount, FMT_COMMON);
}

sub validate_passwords{
    my ($password1, $password2, $old_password) = @_;
    return(0) if ( length($password1) < 4 )
        || ($password1 ne $password2) ;
    return(1) if !$old_password ;
    return( $old_password ne $password1 );
};

sub validate_email{
    my $email = shift;
    return($email =~ /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/) if $email;
    return;
};

sub validate_session{
    my ($self,$search_key) = @_ ;
    return(0) if !$self;
    return $self->session($search_key) ;
};

sub redirect2list_or_path{
    my ($self,$object_names) = @_ ;
    if( !$self || !$object_names){
        warn 'Parameter(s) error!' ;
        return;
    }
    if ( $self->param('path') ){
        $self->redirect_to($self->param('path'));
        return;
    }
    $self->redirect_to("/$object_names/list");
};

sub shrink_if{
    my $self = shift;
    my $string = shift;
    my $length = shift;
    return(undef) if !$string;
    return (substr($string,0,$length) . '...') if length($string) > (5+$length);
    return($string);
};

sub merge2arr_ref{
    my ($arr_ref, $value) = (shift,undef);
    while($value = shift){ push @{$arr_ref}, $value; }
    return($arr_ref);
};

sub get_full_url{
    my $self = shift ;
    my $url_path = $self->req->url->path->to_string() ;
    my $url_query = $self->req->url->query->to_string() ;
    return ($url_query ? "$url_path?$url_query" : $url_path ) ;
};

sub calc_start4ol{
    my $self = shift ;
    my $p = $self->stash('paginator');
    return(1) if !$p ;
    return(($p->[0] - 1) * $p->[2] + 1);
};

sub utf_compare{
    my($self,$a,$b) = @_ ;
    if( !$self || !$a || !$b ){
        warn "Parameters not defined properly to compare!";
        return(0);
    }
    my @a = unpack('U*',$a);
    my @b = unpack('U*',$b);
    my ($a_length, $b_length) = (scalar(@a),scalar(@b));
    my $min_length = ($a_length <= $b_length ? $a_length : $b_length) ;
    return($a_length <=> $b_length) if !$min_length ;
    for(my $i = 0; $i < $min_length; $i++){
        return($a[$i] <=> $b[$i]) if $a[$i] != $b[$i];
    }
    return($a_length <=> $b_length);
};

sub url_append{
    my ($path,$value) = @_ ;
    return(undef) if !$path ;
    return($path) if !$value ;
    return("$path&$value") if $path =~ /\?/ ;
    return("$path?$value") ;
};


# END OF PACKAGE
};

1;

__END__
=head1 AUTHOR
    M.Nurullaev <maksud.nurullaev@gmail.com>
=cut

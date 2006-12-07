package Net::CIDR::MobileJP;
use strict;
use warnings;
use Carp;
use version; our $VERSION = 0.07;
use YAML;
use Net::CIDR::Lite;
use File::ShareDir ();

sub new {
    my ($class, $stuff) = @_;

    return bless {spanner => $class->_create_spanner($stuff)}, $class;
}

sub _create_spanner {
    my ($class, $stuff) = @_;

    my @cidrs;
    my %cidr_for = %{$class->_load_config($stuff)};
    my $spanner = Net::CIDR::Lite->new->spanner;
    while (my ($carrier, $ip_ranges) = each %cidr_for) {
        my $cidr = Net::CIDR::Lite->new;
        for my $ip_range (@$ip_ranges) {
            $cidr->add($ip_range);
        }
        $spanner->add($cidr, $carrier);
    }
    return $spanner;
}

sub _load_config {
    my ($self, $stuff) = @_;

    my $data;
    if (defined $stuff && -f $stuff && -r _) {
        # load yaml from file
        $data = YAML::LoadFile($stuff);
    } elsif ($stuff) {
        # raw data
        $data = $stuff;
    } else {
        # generated file
        $data = YAML::LoadFile(File::ShareDir::module_file('Net::CIDR::MobileJP', 'cidr.yaml'));
    }
    return $data;
}

sub get_carrier {
    my ($self, $ip) = @_;

    my ($carrier,) =  map { keys %$_ } values %{$self->{spanner}->find($ip)};
    return $carrier || 'N';
}


1;
__END__

=head1 NAME

Net::CIDR::MobileJP - mobile ip address in Japan

=head1 SYNOPSIS

    use Net::CIDR::MobileJP;
    my $cidr = Net::CIDR::MobileJP->new('net-cidr-mobile-jp.yaml');
    $cidr->get_carrier('222.7.56.248');
    # => 'E'

=head1 DESCRIPTION

Net::CIDR::MobileJP is an utility to detect an ip address is mobile (cellular) ip address or not.

=head1 METHODS

=head2 new

    my $cidr = Net::CIDR::MobileJP->new('net-cidr-mobile-jp.yaml');  # from yaml
    my $cidr = Net::CIDR::MobileJP->new({E => ['59.135.38.128/25'], ...});

create new instance.

The argument is 'path to yaml' or 'raw data'.

=head2 get_carrier

    $cidr->get_carrier('222.7.56.248');

Get the career name from IP address.

Carrier name is compatible with L<HTTP::MobileAgent>.

=head1 AUTHORS

  Tokuhiro Matsuno  C<< <tokuhiro __at__ mobilefactory.jp> >>
  Jiro Nishiguchi

=head1 THANKS TO

  Tatsuhiko Miyagawa
  Masayoshi Sekimura
  HIROSE, Masaaki

=head1 SEE ALSO

L<http://d.hatena.ne.jp/spiritloose/20061010/1160471510>

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2006, Tokuhiro Matsuno C<< <tokuhiro __at__ mobilefactory.jp> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

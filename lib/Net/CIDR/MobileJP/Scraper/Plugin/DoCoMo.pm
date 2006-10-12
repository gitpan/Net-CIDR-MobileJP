package Net::CIDR::MobileJP::Scraper::Plugin::DoCoMo;
use strict;
use warnings;
use base qw/Net::CIDR::MobileJP::Scraper::Plugin/;

sub run {
    my ($self, ) = @_;

    my $content = $self->get('http://www.nttdocomo.co.jp/service/imode/make/content/ip/about/');
    my @result;
    while ($content =~ m!<FONT COLOR="\#009900"><B>(.*?)</B></FONT>!g) {
        push @result, $1;
    }
    return \@result;
}

1;

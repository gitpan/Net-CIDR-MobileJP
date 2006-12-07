package Net::CIDR::MobileJP::Scraper::Plugin::DoCoMo;
use strict;
use warnings;
use base qw/Net::CIDR::MobileJP::Scraper::Plugin/;

sub url { return 'http://www.nttdocomo.co.jp/service/imode/make/content/ip/about/'; }

sub run {
    my ($self, ) = @_;

    my $url = $self->url;
    my $content = $self->get($url);
    my @result;
    while ($content =~ m!<FONT COLOR="\#009900"><B>(.*?)</B></FONT>!g) {
        push @result, $1;
    }
    return \@result;
}

1;
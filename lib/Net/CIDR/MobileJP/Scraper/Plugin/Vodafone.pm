package Net::CIDR::MobileJP::Scraper::Plugin::Vodafone;
use strict;
use warnings;
use base qw/Net::CIDR::MobileJP::Scraper::Plugin/;

sub run {
    my ($self, ) = @_;

    my $url = 'http://developers.softbankmobile.co.jp/dp/tech_svc/web/ip.php';
    my $content = $self->get($url);

    my @result;
    while ($content =~ m!<FONT size="2" class="j10".*?>(\d+\.\d+\.\d+\.\d+/\d+)</FONT>!g) {
        push @result, $1;
    }
    return \@result;
}

1;

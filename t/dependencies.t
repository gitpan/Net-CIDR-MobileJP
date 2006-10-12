#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
eval q{use Test::Dependencies exclude => [qw/Net::CIDR::MobileJP/];};
plan skip_all => "Test::Dependencies required for testing dependencies" if $@;

ok_dependencies();

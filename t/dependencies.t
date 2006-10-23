#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
eval q{use Test::Dependencies exclude => [qw/Net::CIDR::MobileJP ExtUtils::MakeMaker/];};
plan skip_all => "Test::Dependencies required for testing dependencies" if $@ or $ENV{USER} ne 'tokuhiro';

ok_dependencies();

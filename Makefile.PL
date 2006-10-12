use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Net::CIDR::MobileJP',
    AUTHOR              => 'Tokuhiro Matsuno <tokuhiro __at__ mobilefactory.jp>',
    VERSION_FROM        => 'lib/Net/CIDR/MobileJP.pm',
    ABSTRACT_FROM       => 'lib/Net/CIDR/MobileJP.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'HTTP::MobileAgent'       => 0,
        'Jcode'                   => 0,
        'LWP::UserAgent'          => 0,
        'Module::Pluggable::Fast' => 0,
        'Net::CIDR::Lite'         => 0,
        'UNIVERSAL::require'      => 0,
        'YAML'                    => 0,
        'version'                 => 0,
      },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Net-CIDR-MobileJP-*' },
);

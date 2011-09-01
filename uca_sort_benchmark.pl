#!/usr/bin/env perl

use 5.14.0;
use strict;
use warnings;
use File::Slurp qw(slurp);
use Encode qw(decode_utf8);
use List::MoreUtils qw(uniq);
use autodie;

use Benchmark qw(cmpthese);
use Unicode::Collate::Locale;

# Get unique list of words from specified file
my @words = uniq map { split /\b/u } decode_utf8( slurp(shift) );

# Do benchmark
my $uca = Unicode::Collate::Locale->new( locale => 'nb' );
cmpthese(1_000, {
    'sort' => sub { my @sorted_words =       sort @words  },
    'uca'  => sub { my @sorted_words = $uca->sort(@words) },
});

exit;

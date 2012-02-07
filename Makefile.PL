use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Mojolicious::Plugin::DBIx::Skinny',
  VERSION_FROM => 'lib/Mojolicious/Plugin/DBIx/Skinny.pm',
  AUTHOR       => 'A Good Programmer <nospam@cpan.org>',
  PREREQ_PM    => {'Mojolicious' => '2.0'},
  test         => {TESTS => 't/*.t'}
);

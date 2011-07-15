
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'A stash of config options for Pod::Weaver',
  'AUTHOR' => 'Randy Stauner <rwstauner@cpan.org>',
  'BUILD_REQUIRES' => {
    'Dist::Zilla::Tester' => '0',
    'File::Find' => '0',
    'File::Temp' => '0',
    'ExtUtils::MakeMaker' => '6.30',
    'Test::MockObject' => '0',
    'Test::More' => '0.88'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.30'
  },
  'DISTNAME' => 'Dist-Zilla-Stash-PodWeaver',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'Dist::Zilla::Stash::PodWeaver',
  'PREREQ_PM' => {
    'Dist::Zilla::Role::Stash::Plugins' => '0',
    'Moose' => '0',
    'Pod::Weaver::Config::Assembler' => '0'
  },
  'VERSION' => '1.002',
  'test' => {
    'TESTS' => 't/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);




package Dist::Zilla::Stash::PodWeaver;
BEGIN {
  $Dist::Zilla::Stash::PodWeaver::VERSION = '1.001000';
}
BEGIN {
  $Dist::Zilla::Stash::PodWeaver::AUTHORITY = 'cpan:RWSTAUNER';
}
# ABSTRACT: A stash of config options for Pod::Weaver


use strict;
use warnings;
use Pod::Weaver::Config::Assembler ();
use Moose;
with 'Dist::Zilla::Role::Stash::Plugins';


sub expand_package {
	my ($class, $pack) = @_;
	# Cannot start an ini line with '='
	$pack =~ s/^\+/=/;
	Pod::Weaver::Config::Assembler->expand_package($pack);
}

1;


__END__
=pod

=for :stopwords Randy Stauner PluginBundles PluginName dists zilla dist-zilla Flibberoloo
ini CPAN AnnoCPAN RT CPANTS Kwalitee diff

=head1 NAME

Dist::Zilla::Stash::PodWeaver - A stash of config options for Pod::Weaver

=head1 VERSION

version 1.001000

=head1 SYNOPSIS

	# dist.ini

	[@YourFavoritePluginBundle]

	[%PodWeaver]
	-StopWords:include = WordsIUse ThatAreNotWords

=head1 DESCRIPTION

This performs the L<Dist::Zilla::Role::Stash> role
(using L<Dist::Zilla::Role::DynamicConfig>
and    L<Dist::Zilla::Role::Stash::Plugins>).

When using L<Dist::Zilla::Plugin::PodWeaver>
with a I<config_plugin> it's difficult to pass more
configuration options to L<Pod::Weaver> plugins.

This is often the case when using a
L<Dist::Zilla::PluginBundle|Dist::Zilla::Role::PluginBundle>
that uses a
L<Pod::Weaver::PluginBundle|Pod::Weaver::PluginBundle::Default>.

This stash is intended to allow you to set other options in your F<dist.ini>
that can be accessed by L<Pod::Weaver> plugins.

Because you know how you like your dists built,
(and you're using PluginBundles to do it)
but you need a little extra customization.

=head1 METHODS

=head2 expand_package

Expand shortened package monikers to the full package name.

Changes leading I<+> to I<=> and then passes the value to
I<expand_package> in L<Pod::Weaver::Config::Assembler>.

See L</USAGE> for a description.

=head1 USAGE

The attributes should be named like
C<PluginName:attributes>.
The PluginName will be passed to
C<< Pod::Weaver::Config::Assembler->expand_package() >>
so the PluginName should include the leading character
to identify its type:

=over 4

=item *

C<> (no character) (Pod::Weaver::Section::I<Name>)

=item *

C<-> Plugin (Pod::Weaver::Plugin::I<Name>)

=item *

C<@> Bundle (Pod::Weaver::PluginBundle::I<Name>)

=item *

C<+> Full Package Name (I<Name>)

An ini config line cannot start with an I< = >
so this module will convert any lines that start with I< + > to I< = >.

=back

For example

	Complaints:use_fake_email = 1

Would set the 'use_fake_email' attribute to '1'
for the [fictional] I<Pod::Weaver::Section::Complaints> plugin.

	-StopWords:include = Flibberoloo

Would add 'Flibberoloo' to the list of stopwords
added by the L<Pod::Weaver::Plugin::StopWords> plugin.

	+Some::Other::Module:silly = 1

Would set the 'silly' flag to true on I<Some::Other::Module>.

=head1 BUGS AND LIMITATIONS

=over

=item *

Arguments can only be specified in a F<dist.ini> stash once,
even if the plugin would normally allow multiple entries
in a F<weaver.ini>.  Since the arguments are dynamic (unknown to the class)
the class cannot specify which arguments should accept multiple values.

=item *

Including the package name gives the options a namespace
(instead of trying to set the I<include> attribute for 2 different plugins).

Unfortunately this does not automatically set the options on the plugins.
The plugins need to know to use this stash.

So if you'd like to be able to use this stash with a L<Pod::Weaver>
plugin that doesn't support it, please contact that plugin's author(s)
and let them know about this module.

If you are a L<Pod::Weaver> plugin author,
have a look at
L<Dist::Zilla::Role::Stash::Plugins/get_stashed_config> and
L<Dist::Zilla::Role::Stash::Plugins/merge_stashed_config>
to see easy ways to get values from this stash.

Please contact me (and/or send patches) if something doesn't work
like you think it should.

=back

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

  perldoc Dist::Zilla::Stash::PodWeaver

=head2 Websites

=over 4

=item *

Search CPAN

L<http://search.cpan.org/dist/Dist-Zilla-Stash-PodWeaver>

=item *

RT: CPAN's Bug Tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Dist-Zilla-Stash-PodWeaver>

=item *

AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Dist-Zilla-Stash-PodWeaver>

=item *

CPAN Ratings

L<http://cpanratings.perl.org/d/Dist-Zilla-Stash-PodWeaver>

=item *

CPAN Forum

L<http://cpanforum.com/dist/Dist-Zilla-Stash-PodWeaver>

=item *

CPANTS Kwalitee

L<http://cpants.perl.org/dist/overview/Dist-Zilla-Stash-PodWeaver>

=item *

CPAN Testers Results

L<http://cpantesters.org/distro/D/Dist-Zilla-Stash-PodWeaver.html>

=item *

CPAN Testers Matrix

L<http://matrix.cpantesters.org/?dist=Dist-Zilla-Stash-PodWeaver>

=back

=head2 Bugs

Please report any bugs or feature requests to C<bug-dist-zilla-stash-podweaver at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Dist-Zilla-Stash-PodWeaver>.  I will be
notified, and then you'll automatically be notified of progress on your bug as I make changes.

=head2 Source Code


L<http://github.com/magnificent-tears/Dist-Zilla-Stash-PodWeaver/tree>

  git clone git://github.com/magnificent-tears/Dist-Zilla-Stash-PodWeaver.git

=head1 AUTHOR

Randy Stauner <rwstauner@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Randy Stauner.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


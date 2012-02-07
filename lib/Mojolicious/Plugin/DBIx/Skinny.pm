package Mojolicious::Plugin::DBIx::Skinny;
use Mojo::Base 'Mojolicious::Plugin';

use strict;
use Carp qw(croak);
our $VERSION = '0.01';

sub register {

	my ($self, $app, $config) = @_;

	$app->attr(skinny_instance => sub {

			my $option;
			my $model = $config->{model};
			(my $file = $model) =~ s/::/\//g;

			eval "require '${file}.pm'" or croak($@);
			$model->import;

			my $skinny = $model->new;
			$skinny->connect($config->{dbi_option});
			$skinny->schema->load_schema($config->{dbi_option});
	});

	$app->renderer->add_helper(
		skinny => sub {
					my $self = shift;
					return $self->app->skinny_instance;
				}
	);

}

1;
__END__

=head1 NAME

Mojolicious::Plugin::DBIx::Skinny - Mojolicious Plugin

=head1 SYNOPSIS

  # Mojolicious
  $self->plugin('DBIx::Skinny', { dsn => "dbi:Pg:dbname=foo", username => "bar", password => "", connect_options => { RaiseError => 1, AutoCommit => 1 } });

  # Mojolicious::Lite
  plugin 'DBIx::Skinny', { dsn => "dbi:Pg:dbname=foo", username => "bar", password => "", connect_options => { RaiseError => 1, AutoCommit => 1 } };

  # in your controller
  $self->skinny->single("tb_name", { id => 1 });

=head1 DESCRIPTION

L<Mojolicious::Plugin::DBIx::Skinny> is a L<Mojolicious> plugin.

=head1 METHODS

L<Mojolicious::Plugin::DBIx::Skinny> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 C<register>

  $plugin->register;

Register plugin in L<Mojolicious> application.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=cut

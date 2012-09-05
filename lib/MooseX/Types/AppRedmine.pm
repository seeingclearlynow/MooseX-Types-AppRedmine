package MooseX::Types::AppRedmine;

use 5.008;
use strict;
use warnings;
use namespace::autoclean;

use Class::Load 0.20 qw(load_class);

use MooseX::Types -declare => [ qw(
	RedmineDateTime RedminePriority RedmineStatus RedmineTracker
	RedmineProject RedmineUser
) ];

use MooseX::Types::DateTime qw(DateTime);
use MooseX::Types::Moose qw(Int HashRef);
use MooseX::Types::Common::String qw(NonEmptySimpleStr);

# ABSTRACT:Moose types for App::Redmine
# VERSION

# load_class 'DateTime';
load_class 'App::Redmine::Priority';
load_class 'App::Redmine::Project';
load_class 'App::Redmine::Status';
load_class 'App::Redmine::Tracker';
load_class 'App::Redmine::User';

class_type RedmineDateTime, { class => 'DateTime' };
;
class_type RedminePriority, { class => 'App::Redmine::Priority' };
class_type RedmineProject,  { class => 'App::Redmine::Project' };
class_type RedmineStatus,   { class => 'App::Redmine::Status' };
class_type RedmineTracker,  { class => 'App::Redmine::Tracker' };
class_type RedmineUser,     { class => 'App::Redmine::User' };

coerce RedmineDateTime,
	from NonEmptySimpleStr,
	via {
		my ( $string ) = @_;

		return DateTime->now() unless $string;

		my ( $p1, $p2, $p3 )  = split( ' ', $string );
		my ( $y, $m, $d )     = split( '/', $p1 );
		my ( $h, $i, $s )     = split( ':', $p2 );

		$p3                   =~ /^$/x;

		my $dt                 = DateTime->new(
			year => $y, month => $m, day => $d, hour => $h, minute => $i, second => $s,
			time_zone => 'America/Chicago',
		);

		return $dt;
	};

coerce RedminePriority,
  from HashRef,
  via  { App::Redmine::Priority->new( $_ ) };

coerce RedminePriority,
  from Int,
  via  { App::Redmine::Priority->new( { id => $_ } ) };

coerce RedminePriority,
  from NonEmptySimpleStr,
  via  { App::Redmine::Priority->new( { name => $_ } ) };

coerce RedmineProject,
  from HashRef,
  via  { App::Redmine::Project->new( $_ ) };

coerce RedmineStatus,
  from HashRef,
  via  { App::Redmine::Status->new( $_ ) };

coerce RedmineStatus,
  from Int,
  via  { App::Redmine::Status->new( { id => $_ } ) };

coerce RedmineStatus,
  from NonEmptySimpleStr,
  via  { App::Redmine::Status->new( { name => $_ } ) };

coerce RedmineTracker,
  from HashRef,
  via  { App::Redmine::Tracker->new( $_ ) };

coerce RedmineTracker,
  from Int,
  via  { App::Redmine::Tracker->new( { id => $_ } ) };

coerce RedmineTracker,
  from NonEmptySimpleStr,
  via  { App::Redmine::Tracker->new( { name => $_ } ) };

coerce RedmineUser,
  from HashRef,
  via  { App::Redmine::User->new( $_ ) };

1;

=pod

=head1 SYNOPSIS

	{
		package My::thing;

		use Moose;
		use MooseX::Types::AppRedmine qw(
			RedminePriority RedmineProject RedmineStatus RedmineTracker RedmineUser
		);

		has tracker => (
			isa       => RedmineTracker,
			is        => 'rw',
			required  => 0,
			coerce    => 1,
			lazy      => 1,
		);
	}

	my $thing = My::Thing->new( tracker => 5 );

	my $tracker = $thing->tracker->name();

=head1 DESCRIPTION

L<MooseX::Types::AppRedmine> provides type constraints and coercion rules for Moose attributes to App::Redmine objects.

=head1 TYPES

=over 4

=item RedminePriority

An L<App::Redmine::Priority> object

=item RedmineProject

An L<App::Redmine::Project> object

=item RedmineStatus

An L<App::Redmine::Status> object

=item RedmineTracker

An L<App::Redmine::Tracker> object

=item RedmineUser

An L<App::Redmine::User> object

=back

=head1 COERCIONS

=over 4

=item RedminePriority

=over 8

=item From HashRef

=item From Int

=item From NonEmptySimpleStr

=back

=item RedmineProject

=over 8

=item From HashRef

=back

=item RedmineStatus

=over 8

=item From HashRef

=item From Int

=item From NonEmptySimpleStr

=back

=item RedmineTracker

=over 8

=item From HashRef

=item From Int

=item From NonEmptySimpleStr

=back

=item RedmineUser

=over 8

=item From HashRef

=item From Int

=item From NonEmptySimpleStr

=back

=back

=cut

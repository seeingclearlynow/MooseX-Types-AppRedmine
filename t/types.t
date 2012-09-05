#!/usr/bin/env perl

use 5.008;
use strict;
use warnings;

use Class::Load 0.20 qw(load_class);
use Test::More;

{
	package My::Thing;

	use Moose;
	use MooseX::Types::AppRedmine qw(RedminePriority RedmineProject RedmineStatus RedmineTracker RedmineUser);

	has priority => (
		isa       => RedminePriority,
		is        => 'rw',
		required  => 0,
		lazy      => 0,
	);

	has project  => (
		isa       => RedmineProject,
		is        => 'rw',
		required  => 0,
		lazy      => 0,
	);

	has status   => (
		isa       => RedmineStatus,
		is        => 'rw',
		required  => 0,
		lazy      => 0,
	);

	has tracker  => (
		isa       => RedmineTracker,
		is        => 'rw',
		required  => 0,
		lazy      => 0,
	);

	has User     => (
		isa       => RedmineUser,
		is        => 'rw',
		required  => 0,
		lazy      => 0,
	);
}

my $class        = 'My::Thing';
my $types        = [ qw(Priority Project Status Tracker User) ];

foreach my $type ( @$types ) {
	my $type_class = "App::Redmine::$type";
	my $data       = {};

	new_ok $class, [ { lc( $type ) => load_class( $type_class )->new( $data ) } ];
}

done_testing;

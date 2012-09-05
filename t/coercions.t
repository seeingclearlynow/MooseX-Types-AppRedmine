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
	);

	has project  => (
		isa       => RedmineProject,
		is        => 'rw',
	);

	has status   => (
		isa       => RedmineStatus,
		is        => 'rw',
	);

	has tracker  => (
		isa       => RedmineTracker,
		is        => 'rw',
	);

	has User     => (
		isa       => RedmineUser,
		is        => 'rw',
	);
}

my $class        = 'My::Thing';

new_ok $class, [ { priority => { id => 1, name => 'low' } } ];
new_ok $class, [ { priority => 1 } ];
new_ok $class, [ { priority => 'low' } ];

new_ok $class, [ { project => {
	id          => 1,
	name        => 'Test Project',
	description => 'Project for testing',
} } ];

new_ok $class, [ { status => { id => 1, name => 'New' } } ];
new_ok $class, [ { status => 1 } ];
new_ok $class, [ { status => 'New' } ];

new_ok $class, [ { tracker => { id => 1, name => 'Bug' } } ];
new_ok $class, [ { tracker => 1 } ];
new_ok $class, [ { tracker => 'New' } ];

new_ok $class, [ { user => {
	id         => 1,
	first_name => 'Test'
	last_name  => 'User',
	mail       => 'test.user@example.com',
} } ];

done_testing;

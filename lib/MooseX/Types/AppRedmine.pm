package MooseX::Types::AppRedmine;

use 5.010;
use strict;
use warnings;
use namespace::autoclean;

use MooseX::Types -declare => [ qw(
	RedminePriority RedmineProject RedmineStatus RedmineTracker RedmineUser
) ];
use App::Redmine::Priority;
use App::Redmine::Project;
use App::Redmine::Status;
use App::Redmine::Tracker;
use App::Redmine::User;
use MooseX::Types::Moose qw(HashRef);
use MooseX::Types::Common::String qw(NonEmptySimpleStr);

# ABSTRACT:Moose types for App::Redmine
# VERSION

class_type RedminePriority, { class => 'App::Redmine::Priority' };
class_type RedmineProject,  { class => 'App::Redmine::Project' };
class_type RedmineStatus,   { class => 'App::Redmine::Status' };
class_type RedmineTracker,  { class => 'App::Redmine::Tracker' };
class_type RedmineUser,     { class => 'App::Redmine::User' };

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

  package My::thing;

  use Moose;
  use MooseX::Types::AppRedmine qw(
	RedminePriority RedmineProject RedmineStatus RedmineTracker RedmineUser
);

  has  => (
    isa    => Domain,
    is     => 'rw',
    coerce => 1,
  );

=head1 DESCRIPTION

MooseX::types::NetEntityDomain provides type constraints and coercions for Moose attributes to Net::Entity::Domain objects.

=head1 TYPES

=over 4

=item Domain

=back

=head1 COERCIONS

Currently, only coercions from strings are supported.

=cut

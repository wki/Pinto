package Pinto::Schema::Result::Package;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Pinto::Schema::Result::Package

=cut

__PACKAGE__->table("package");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 version

  data_type: 'text'
  is_nullable: 0

=head2 distribution

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 0 },
  "version",
  { data_type => "text", is_nullable => 0 },
  "distribution",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 distribution

Type: belongs_to

Related object: L<Pinto::Schema::Result::Distribution>

=cut

__PACKAGE__->belongs_to(
  "distribution",
  "Pinto::Schema::Result::Distribution",
  { id => "distribution" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-09-04 17:03:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:EuTRdG3SyHHfpX0wB5J/wA

#------------------------------------------------------------------------------

=method to_string()

Returns this Package as a string containing the package name.  This is
what you get when you evaluate and Package in double quotes.

=cut

sub to_string {
    my ($self) = @_;

    return $self->name();
}

#------------------------------------------------------------------------------

=method to_index_string()

Returns this Package object as a string that is suitable for writing
to an F<02packages.details.txt> file.

=cut

sub to_index_string {
    my ($self) = @_;

    my $fw = 38 - length $self->version();
    $fw = length $self->name() if $fw < length $self->name();

    return sprintf "%-${fw}s %s  %s\n", $self->name(),
                                        $self->version(),
                                        $self->dist->location();
}

#-------------------------------------------------------------------------------
1;

__END__
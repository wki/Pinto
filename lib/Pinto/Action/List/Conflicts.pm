package Pinto::Action::List::Conflicts;

# ABSTRACT: Action that lists conflicted packages in a repository

use Moose;

extends 'Pinto::Action::List';

use namespace::autoclean;

#------------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------

override execute => sub {
    my ($self) = @_;

    for my $package ( $self->idxmgr->conflict_packages() ) {
        print { $self->out() } $package->to_index_string();
    }

    return 0;
};

#------------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#------------------------------------------------------------------------------

1;

__END__
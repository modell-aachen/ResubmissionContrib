#!/usr/bin/perl -w

# Standard preamble
BEGIN {
    foreach my $pc ( split( /:/, $ENV{FOSWIKI_LIBS} ) ) {
        unshift @INC, $pc;
    }
}

use Foswiki::Contrib::Build;

package ResubmissionBuild;

@ResubmissionBuild::ISA = ("Foswiki::Contrib::Build");

sub new {
    my $class = shift;
    return bless( $class->SUPER::new("ResubmissionContrib"), $class );
}

$build = new ResubmissionBuild();

$build->build( $build->{target} );

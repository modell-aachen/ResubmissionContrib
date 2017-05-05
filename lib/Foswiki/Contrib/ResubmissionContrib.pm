# See bottom of file for license and copyright information

package Foswiki::Contrib::ResubmissionContrib;

use strict;
use warnings;

our $VERSION = '1.0';
our $RELEASE = '1.0';
our $SHORTDESCRIPTION =
  'This Contrib provides a resubmission for abandoned topcis.';

our $SITEPREFS = {
    RESUBMISSION_WEBS => 'Processes',
    RESUBMISSION_STATES => 'approved,discussion,draft',
    RESUBMISSION_APPROVED => '365',
    RESUBMISSION_DISCUSSION => '30',
    RESUBMISSION_DRAFT => '30',
    RESUBMISSION_IGNORE => '*Template',
    RESUBMISSION_SENDMAIL => '0',
    RESUBMISSION_SENDMAIL_GROUP => 'KeyUserGroup',
    RESUBMISSION_SENDMAIL_RESPONSIBLE => 1
};

# MaintenancePlugin compatibility
sub maintenanceHandler {
    Foswiki::Plugins::MaintenancePlugin::registerCheck("resubmission:topic", {
        name => "Resubmission topic is missing",
        description => "Topic with all Topics for Resubmission is missing",
        check => sub {
            require File::Spec;
            my $file = File::Spec->catfile('data', 'Main', 'Resubmission.txt');
            if(!-e $file) {
                return {
                    result => 1,
                    priority => $Foswiki::Plugins::MaintenancePlugin::ERROR,
                    solution => "Copy Resubmission.txt from _apps/Resubmission to Main"
                }
            }
            return { result => 0 };
        }
    });
    Foswiki::Plugins::MaintenancePlugin::registerCheck("resubmission:crontab", {
        name => "Send resubmission mails",
        description => "Crontab with sendmail for resubmission should be existent.",
        check => sub {
            require File::Spec;
            my $file = File::Spec->catfile('/', 'etc', 'cron.d', 'foswiki_jobs');
            if( -e $file) {
                open(my $fh, '<', $file);
                local $/;
                my $result = $fh !~ /ResubmissionMail/;
                close $fh;
                if($result) {
                    return {
                        result => 1,
                        priority => $Foswiki::Plugins::MaintenancePlugin::ERROR,
                        solution => "Add cronjob to foswiki_jobs according the documentation. [[%SYSTEMWEB%.ResubmissionContrib]]"
                    }
                }
            }
            return { result => 0 };
        }
    });
}

1;
__END__
Foswiki - The Free and Open Source Wiki, http://foswiki.org/

Copyright (C) 2008-2017 Foswiki Contributors. Foswiki Contributors
are listed in the AUTHORS file in the root of this distribution.
NOTE: Please extend that file, not this notice.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version. For
more details read LICENSE in the root of this distribution.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

As per the GPL, removal of this notice is prohibited.

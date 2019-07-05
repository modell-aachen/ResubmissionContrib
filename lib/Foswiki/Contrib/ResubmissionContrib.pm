# See bottom of file for license and copyright information

package Foswiki::Contrib::ResubmissionContrib;

use strict;
use warnings;

our $VERSION = '1.0';
our $RELEASE = '1.0';
our $SHORTDESCRIPTION =
  'This Contrib provides a resubmission for abandoned topcis.';

our $SITEPREFS = {
    RESUBMISSION_WEBS => '*Processes -OUTemplate.Processes -Settings.Processes ',
    RESUBMISSION_STATES => 'approved,discussion,draft',
    RESUBMISSION_APPROVED => '365',
    RESUBMISSION_DISCUSSION => '180',
    RESUBMISSION_DRAFT => '180',
    RESUBMISSION_IGNORE => '*Template',
    RESUBMISSION_SENDMAIL => 1,
    RESUBMISSION_SENDMAIL_GROUP => 'KeyUserGroup',
    RESUBMISSION_SENDMAIL_RESPONSIBLE => 1,
    RESUBMISSION_HEADERS => '%IF{"$USE_PROCESS_DOCUMENT_NUMBER" then="Document number,"}%Titel,Responsible,Status,In state since,In resubmission since',
    RESUBMISSION_FIELDS =>'%IF{"$USE_PROCESS_DOCUMENT_NUMBER" then="text-field(field_DocumentNumber_s),"}%url-field(title, url),text-field(field_Responsible_dv_s),text-field(workflowstate_displayname%IF{"$LANGUAGE=de" then=de}%_s),date-field(workflowmeta_lasttime_currentstate_dt,1),date-field(workflowmeta_lasttimecurrentstatetype_dt,1)',
    RESUBMISSION_SORTFIELDS => '%IF{"$USE_PROCESS_DOCUMENT_NUMBER" then="field_DocumentNumber_s,"}%title_sort,field_Responsible_dv_s,workflowstate_displayname%IF{"$LANGUAGE=de" then="de"}%_s,workflowmeta_lasttime_currentstate_dt,workflowmeta_lasttimecurrentstatetype_dt',
    RESUBMISSION_FACETS => 'select-2-facet(Responsible,field_Responsible_dv_s),multi-select-facet(Status,workflowstate_displayname%IF{"$LANGUAGE=de" then=de}%_s),multi-select-facet(Webs, web)',
    RESUBMISSION_INITIALSORT => 'workflowmeta_lasttime_currentstate_dt,asc',
    RESUBMISSION_FIELDRESTRICTION => '%IF{"$USE_PROCESS_DOCUMENT_NUMBER" then="field_DocumentNumber_s,"}%field_Responsible_dv_s,workflowstate_displayname%IF{"$LANGUAGE=de" then="de"}%_s,web,title,url,workflowmeta_lasttime_currentstate_dt,workflowmeta_lasttimecurrentstatetype_dt',
    RESUBMISSION_SETTINGS_WEBHOME => '%IF{"istopic Settings.WebHome" then="" else="form=\"Processes.DocumentForm\""}%',
    RESUBMISSION_EXCELEXPORT => '1',
    RESUBMISSION_FILTERS => 'full-text-filter(Title,title_search)',
    RESUBMISSION_INFOPAGE => '',
};

# MaintenancePlugin compatibility
sub maintenanceHandler {
    Foswiki::Plugins::MaintenancePlugin::registerCheck("resubmission:topic", {
        name => "Resubmission topic is missing",
        description => "Topic with all Topics for Resubmission is missing",
        check => sub {
            unless(Foswiki::Func::topicExists($Foswiki::cfg{UsersWebName}, 'Resubmission')) {
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
                local $/ = undef;
                my $hasResubmissionMail = <$fh> =~ /\bResubmissionMail\b/;
                close $fh;
                unless($hasResubmissionMail) {
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

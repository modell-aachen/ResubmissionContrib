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
    RESUBMISSION_IGNORE => '(Web* OR *Template)',
    RESUBMISSION_SENDMAIL => '0',
    RESUBMISSION_SENDMAIL_GROUP => 'KeyUserGroup',
    RESUBMISSION_SENDMAIL_RESPONSIBLE => 1
};

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

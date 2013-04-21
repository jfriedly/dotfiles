#!/usr/bin/env python
# gcsms.py - Send SMS to your phone for free using Google Calendar
# Copyright (C) 2013    Mansour <mansour@oxplot.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.    See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.    If not, see <http://www.gnu.org/licenses/>.

"""
gcsms.py - Send SMS to your phone for free using Google Calendar
"""

from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals
from datetime import datetime
import argparse
import json
import os
import sys
import time

# Version dependent imports

try:
    from ConfigParser \
        import SafeConfigParser, NoSectionError, NoOptionError
except ImportError:
    from configparser \
        import SafeConfigParser, NoSectionError, NoOptionError

try:
    from urllib2 import urlopen, Request
    from urllib import urlencode
except ImportError:
    from urllib.parse import urlencode
    from urllib.request import urlopen, Request

_progname = 'gcsms'
_global = 'global'
_scope = 'https://www.googleapis.com/auth/calendar'
_dev_code_endpt = 'https://accounts.google.com/o/oauth2/device/code'
_token_endpt = 'https://accounts.google.com/o/oauth2/token'
_grant_type = 'http://oauth.net/grant_type/device/1.0'
_cal_url = 'https://www.googleapis.com/calendar/v3'
_event_path = '/calendars/%s/events'
_cal_list_path = '/users/me/calendarList'
_cals_path = '/calendars'


class GCSMSError(Exception):
    """Generic exception raised when anything goes wrong."""
    pass


def cmd_auth(args, cfg):
    """Authenticate with Google."""

    # Obtain a user code

    req = Request(
        _dev_code_endpt,
        data=urlencode({
            'client_id': cfg.get(_global, 'client_id'),
            'scope': _scope
        }).encode('utf8')
    )
    ucres = json.loads(urlopen(req).read().decode('utf8'))

    print("Visit %s\nand enter the code '%s'\n"
          "Waiting for you to grant access ..."
          % (ucres['verification_url'], ucres['user_code']))

    # Obtain refresh token by polling token end point

    req = Request(
        _token_endpt,
        data=urlencode({
            'client_id': cfg.get(_global, 'client_id'),
            'client_secret': cfg.get(_global, 'client_secret'),
            'code': ucres['device_code'],
            'grant_type': _grant_type
        }).encode('utf8')
    )

    while True:
        rtres = json.loads(urlopen(req).read().decode('utf8'))
        error = rtres.get('error', None)
        refresh_token = rtres.get('refresh_token', None)
        if error in ('slow_down', 'authorization_pending'):
            time.sleep(int(ucres['interval']))
        elif error:
            raise GCSMSError("got auth error '%s' while polling" % error)
        elif refresh_token:
            break
        else:
            raise GCSMSError('unexpected error while polling')

    # Store the refresh token in the config file

    cfg.set(_global, 'refresh_token', refresh_token)
    cfg.write(open(args.config + ".tmp", 'w'))
    os.rename(args.config + ".tmp", args.config)

    print("Successful. You can now use 'gcsms send' to send SMS")


def cmd_send(cfg, text=None):
    """Send SMS."""

    try:
        cfg.get(_global, 'refresh_token')
    except NoOptionError:
        raise GCSMSError("you must first run 'gcsms auth' to authenticate")

    # Obtain an access token

    req = Request(
        _token_endpt,
        data=urlencode({
            'client_id': cfg.get(_global, 'client_id'),
            'client_secret': cfg.get(_global, 'client_secret'),
            'refresh_token': cfg.get(_global, 'refresh_token'),
            'grant_type': 'refresh_token'
        }).encode('utf8')
    )
    tres = json.loads(urlopen(req).read().decode('utf8'))
    access_token = tres.get('access_token', None)
    if access_token is None:
        raise GCSMSError("you must first run 'gcsms auth' to authenticate")

    # Get a list of all calendars

    callist = do_api(
        '%s?minAccessRole=writer&showHidden=true' % _cal_list_path,
        access_token, None
    )['items']
    cal = None
    for c in callist:
        if c['summary'] == _progname:
            cal = c['id']
            break

    # If our calendar doesn't exist, create one

    if cal is None:
        cres = do_api(_cals_path, access_token, {'summary': _progname})
        if cres.get('summary', None) == _progname:
            cal = cres['id']
        else:
            raise GCSMSError('cannot create calendar')

    # Read the stdin and create a calendar event out of it

    if text is None:
        text = sys.stdin.read()
    try:
        ts = datetime.utcfromtimestamp(
            time.time() + 65).isoformat(b'T') + 'Z'
    except TypeError:
        ts = datetime.utcfromtimestamp(
            time.time() + 65).isoformat('T') + 'Z'
    event = {
        'start': {'dateTime': ts},
        'end': {'dateTime': ts},
        'reminders': {
            'useDefault': False,
            'overrides': [
                {'method': 'sms', 'minutes': 1}
            ]
        },
        'summary': text,
        'visibility': 'private',
        'transparency': 'transparent'
    }

    cres = do_api(_event_path % cal, access_token, event)
    if cres.get('kind', None) != 'calendar#event':
        raise GCSMSError('failed to send SMS')


def do_api(path, auth, body):
    """Make a Google Calendar API request."""
    req = Request(
        '%s%s' % (_cal_url, path),
        data=json.dumps(body).encode('utf8') if body else None,
        headers={
            'Authorization': 'Bearer %s' % auth,
            'Content-type': 'application/json'
        }
    )
    return json.loads(urlopen(req).read().decode('utf8'))


def main():
    """gcsms.py - Send SMS to your phone for free using Google Calendar.

    Use gcsms.py auth to authenticate with Google
    Pipe a data stream to gcsms.py send to have the data texted to your number.
    """

    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawDescriptionHelpFormatter,
        description='Send SMS to yourself with Google Calendar'
    )
    parser.add_argument(
        '-c', '--config',
        default=os.path.expanduser('~/.gcsms'),
        metavar='<config>',
        help='path to config file - default is ~/.gcsms'
    )
    subparsers = parser.add_subparsers(
        help='gcsms commands',
        dest='command'
    )
    subparsers.add_parser(
        'auth',
        help='authenticate with Google'
    )
    subparsers.add_parser(
        'send',
        help='send SMS'
    )
    args = parser.parse_args()

    try:

        cfg = SafeConfigParser()
        if os.path.exists(args.config):
            cfg.read(args.config)
        else:
            raise GCSMSError("config file doesn't exist")

        try:
            cfg.get(_global, 'client_id')
            cfg.get(_global, 'client_secret')
        except (NoOptionError, NoSectionError):
            raise GCSMSError(
                '"client_id" and/or "client_secret" is missing in config')

        if args.command == 'auth':
            cmd_auth(args, cfg)
        elif args.command == 'send':
            cmd_send(cfg)

    except GCSMSError as e:
        print('%s: error: %s' % (_progname, e.args[0]), file=sys.stderr)
        exit(2)
    except KeyboardInterrupt:
        print('%s: keyboard interrupt' % _progname)
        exit(2)

if __name__ == '__main__':
    main()

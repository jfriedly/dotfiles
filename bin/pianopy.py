#!/usr/bin/python
"""
Pianopy - Temporarily blacklist songs from headless_pianobar by running pianopy

Pianopy takes an argument, which should be a file that looks like this::

    |>  "Step One Two" by "Kaskade" on "Strobelight Seduction"
    |>  "Club Sound" by "David Kane" on "Live At Pacha Club Ibiza"
    ...

Then Pianopy silently watches your headless_pianobar for each of the songs in
this list and will skip them when they come up.
To build the list, simply copy/paste songs from pianobar's output into it.

Note:  Don't copy-paste in the heart characters that appear at the end of
lines on songs you love.
"""


import os
import time
import re
import sys


def next_song(home):
    """Plays the next song.
    """
    print "Song contains lyrics, skipping"
    with open("{0}/.config/pianobar/ctl".format(home), 'w') as ctl:
        ctl.write('n')


def lyrical(songname):
    """Returns True if a song is on the lyrical songs list, else False.
    """
    # This makes us open and close the file pretty often, but there's no
    # other good way to ensure the file gets closed at the end.
    with open(sys.argv[1], 'r') as lyrical_songs:
        print songname
        # Strip hearts and add newlines
        if songname.rstrip(' <3') + '\n' in lyrical_songs.xreadlines():
            return True
        return False


def _check_args(headless_pianobar_outfile):
    """Checks the arguments passed to pianopy for errors.
    """
    if not len(sys.argv) > 1 or not os.path.exists(sys.argv[1]):
        print "Pianopy must be passed a file containing a list of banned songs"
        sys.exit(1)
    if not os.path.exists(headless_pianobar_outfile):
        print ("Pianopy must be run based on a pianobar output file.  Run "
               "headless_pianobar or redirect stdout to "
               "~/.config/pianobar/out")
        sys.exit(2)


def main():
    print "Welcome to pianopy.  Press Ctrl-C to exit."
    home = os.environ['HOME']
    regex = re.compile(r'\|>  ".*')
    headless_pianobar_outfile = "{0}/.config/pianobar/out".format(home)
    _check_args(headless_pianobar_outfile)

    with open(headless_pianobar_outfile, 'r') as outfile:
        initial_output = outfile.read().strip()
        initial_song = regex.findall(initial_output)[-1]
        if lyrical(initial_song):
            next_song(home)

        while True:
            time.sleep(1)
            # If headless_pianobar is killed, it start writing at byte zero
            # again, but we'll still be trying to read from some later byte n.
            # This detects if the file's length is less than where we will
            # read from and seeks to byte zero if so.
            if os.stat(headless_pianobar_outfile).st_size < outfile.tell():
                outfile.seek(0)
            updated = outfile.read().strip()
            songname = regex.search(updated)
            if songname is None:
                continue
            elif lyrical(songname.group()):
                next_song(home)


if __name__ == "__main__":
    main()

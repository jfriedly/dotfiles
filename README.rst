=====
About
=====

This repo will host my config files for things like vim, bash, ssh, and such.
It's on GitHub so that I can easily keep track fo what I did before and get these files onto new machines that I use.

If you'd like to use it yourself, clone the repo and run setup.sh.
That will automatically move in my id_rsa.pub and my authorized_keys, so you'll want to wipe those.

gcsms.py
--------
This script is based on the `gcsms repo`_ by oxplot.
It will read from stdin (or a keyword argument) and create a Google Calendar event for you one minute in the future with an SMS notification set up.
Google will then text you the first few words stdout, which is very useful when you have long-running operations but want to know as soon as they finish.
To set it up, type ``gcsms.py auth`` on the computer it will be connecting to Google calendar from.
Then go to https://google.com/device and paste in the code in your terminal.
You can now pipe anything to ``gcsms.py send`` to have it texted to you.

Note, use gcsms in tmux this way:

.. code:: bash

    long_running_command; echo "Finished long_running_command" | gcsms.py send

Not this way:

.. code:: bash

    long_running_command | gcsms.py send

I learned the hard way that occasionally gcsms will have a hiccup sending, and it really sucks to lose the output of your long running command when that was often all you really cared about.

.. _gcsms repo: https://github.com/oxplot/gcsms

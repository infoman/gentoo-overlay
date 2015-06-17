WARNING
=======

This overlay contains outdated ebuilds. Please use official ones or find
another overlay if possible. Updates here are rare and irregular.

How to add this repo using layman
=================================

Edit /etc/layman/layman.cfg:

    sudo vim /etc/layman/layman.cfg

Find the following line:

    overlays  : http://www.gentoo.org/proj/en/overlays/repositories.xml

Add my layman.xml after it so the resulting lines will look like:

    overlays  : http://www.gentoo.org/proj/en/overlays/repositories.xml
                http://infoman.yo.md/gentoo/layman.xml
                # Some other custom list can be here

Then you can add the 'infoman' repo just like any other overlay:

    sudo layman -a infoman

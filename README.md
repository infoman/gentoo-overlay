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

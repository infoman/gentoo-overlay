Doobry's Gentoo Overlay
=======================
This is a gentoo overlay for random ebuilds I have written or downloaded that I use.

Emerging Layman
---------------
This simplest way to manage your overlays is with layman, which can be emerged with:

    emerge layman
    
Remember to add the layman source to /etc/make.conf as instructed by the emerge output.

Adding the Overlay
------------------
You can add this overlay using layman with:

    layman -f -o http://github.com/doobry/doobry-overlay/raw/master/layman.xml -a doobry
 
You should also add the url to the list of remote overlays in /etc/layman/layman.cfg

Removing the Overlay
--------------------
You can remove this overlay from layman with:

    layman -d doobry

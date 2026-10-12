# The bazaar that worked: Linus Torvalds, Linux and Git {#sec:bazaar}

On 25 August 1991, a student at the University of Helsinki sent a message to the Usenet group
`comp.os.minix`. He wrote that he was "doing a (free) operating system (just a hobby, won't be big
and professional like gnu)" for 386 and 486 AT clones. He asked what people wanted to see in it
[@torvalds1991minix]. Version 0.01 followed on 17 September 1991. In early 1992, Torvalds changed
the licence of the kernel to the GNU General Public License. Version 0.95, in March 1992, was the
first release under this licence [@wikipedia2026linuxhistory].

The hobby became the most widely deployed operating-system kernel in history. It runs on servers,
phones, routers, cars and the supercomputers on which much of computational science depends. We do
not need a market-share figure for this point. Almost certainly, the reader's own week went through
several Linux machines.

The first achievement of Torvalds was not only technical. *The Cathedral and the Bazaar*, the
account by Eric Raymond of Linux development, identified the social method behind it. The method is
to release early, release often, treat users as co-developers, and let many eyes find bugs that few
eyes would find [@raymond1998cathedral]. Raymond compared this *bazaar* with the *cathedral*, in
which development is carefully guarded and centrally planned. Linux showed that the bazaar could
build the hardest kind of software that exists.

The second achievement of Torvalds came from a failure of closed source. From 2002, the kernel used
BitKeeper, a closed-source version-control system that was available at no cost. In April 2005, that
free access ended. No free system met the needs of the project, so Torvalds wrote his own. He
started on 3 April 2005, and on 7 April Git managed its own source code. The first multi-branch
merge followed on 18 April, and on 26 July he gave maintenance to Junio Hamano [@wikipedia2026git].

The first commit in the Git repository is still readable today. Its title is "Initial revision of
"git", the information manager from hell" [@torvalds2005git].

**[ANALYSIS]** The BitKeeper episode is a small parable for this paper. The kernel community
accepted a closed tool for convenience, and was exposed when the owner withdrew it. When Torvalds
replaced it with an open tool, the replacement became the base of almost all software development.
This base includes the repositories, pull requests and release tags through which this paper is
built and archived. Git's data model has the ethic that Section [-@sec:citing] argues for: each
commit names its author and points by cryptographic hash to its exact history. Git is a citation
graph for code.

We praise Torvalds here without reservation for these two gifts, and for three decades of
maintenance of the first gift. We also note what this praise does not require. It does not require
that others copy the technical style of one person, or that open source is free of conflict. The
claim is narrower and stronger. At the largest scale that anyone ever tried, openness worked.

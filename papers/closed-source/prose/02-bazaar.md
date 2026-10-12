# The bazaar that worked: Linus Torvalds, Linux and Git {#sec:bazaar}

On 25 August 1991, a student at the University of Helsinki posted to the Usenet group
`comp.os.minix` that he was "doing a (free) operating system (just a hobby, won't be big and
professional like gnu)" for 386 and 486 AT clones, and asked what people would like to see in it
[@torvalds1991minix]. Version 0.01 followed on 17 September 1991. In early 1992 Torvalds moved
the kernel to the GNU General Public License, and version 0.95, in March 1992, was the first
release under it [@wikipedia2026linuxhistory].

The hobby became the most widely deployed operating-system kernel in history. It runs on
servers, phones, routers, cars and the supercomputers on which much of computational science
depends. I do not need a market-share figure to make the point; the reader's own week almost
certainly passed through several Linux machines.

Torvalds' first achievement was not only technical. Eric Raymond's account of Linux development,
*The Cathedral and the Bazaar*, identified the social method behind it: release early, release
often, treat users as co-developers, and let many eyes find bugs that few would
[@raymond1998cathedral]. Raymond contrasted this *bazaar* with the *cathedral* of carefully
guarded, centrally planned development. Linux showed that the bazaar could build the hardest
kind of software there is.

Torvalds' second achievement came from a failure of closed source. From 2002 the kernel used
BitKeeper, a proprietary version-control system offered at no cost. In April 2005 that free access
ended. No free system met the project's needs, so Torvalds wrote his own. He began on 3 April
2005; on 7 April Git was managing its own source code; the first multi-branch merge followed on
18 April; and on 26 July he handed maintenance to Junio Hamano [@wikipedia2026git]. The first
commit in the Git repository, still readable today, is titled "Initial revision of "git", the
information manager from hell" [@torvalds2005git].

**[ANALYSIS]** The BitKeeper episode is a small parable for this paper. The kernel community had
accepted a closed tool for convenience. When the owner withdrew it, the community was exposed;
when Torvalds replaced it with an open one, the replacement became the substrate of nearly all
software development, including the repositories, pull requests and release tags through which
this paper is built and archived. Git also embodies, in its data model, the ethic I argue for in
Section [-@sec:citing]: every commit names its author and points, by cryptographic hash, to the
exact history it builds on. Git is a citation graph for code.

I praise Torvalds here without reservation for those two gifts and for three decades of
maintaining the first. I also note what the praise does not require: that one person's
technical style be copied, or that open source be free of conflict. The claim is narrower and
stronger. Openness, at the largest scale ever attempted, worked.

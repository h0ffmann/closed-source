---
name: pirsig-slips
description: "Work with ideas the way Robert M. Pirsig did in Lila: on paper slips, one idea each, kept in card-catalog trays and sorted by hand until an order comes out of them. Use when the owner asks for Pirsig's slips, the slip method, slip box or trays; wants slips to copy by hand; sends photos or a transcript of paper slips to sort, file or turn into notes; or asks what comes first in a pile of ideas. The paper is the master copy; the repository holds only what the owner chooses to keep."
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# pirsig-slips

Pirsig's notes were analog. In *Lila* (1991), chapter 2, his Phaedrus keeps "about eleven
thousand" four-by-six slips of note pad paper in four long card-catalog trays, after nearly four
years of work on a Metaphysics of Quality. No computer and no notebook: paper slips, sorted by
hand. This skill keeps it that way. The owner writes, holds and sorts the slips. The agent helps
around the paper: it cuts a text into slip-sized ideas to copy by hand, reads photos of slips,
asks which slip comes first, and files a slip in `notes/` only when the owner asks.

## The method, from the book

Each point is Pirsig's, from *Lila*, chapter 2 (Sources). Quotations are exact.

1. **A slip, not a sheet.** A small slip of paper, four by six inches. "A card-catalog tray full
   of slips provides a more random access" than full-sized sheets. One idea fits one slip.
2. **Random access.** "When information is organized in small chunks that can be accessed and
   sequenced at random it becomes much more valuable" than the same information in a fixed
   order. Any slip can move next to any other.
3. **To forget.** "The main purpose of the slips was not to help him remember anything. It was to
   help him to forget it." A thought goes on a slip at once, without judgement and without a
   place, so the head stays empty for the next one.
4. **No plan first.** He did not start with a master idea. Topics grew out of the slips, then
   sections, chapters and parts. The order was "democratically elected by the slips themselves."
5. **Sort by pairs.** Hold up two slips and ask, "Which comes first?" Then take a third and ask
   it of the first, and go on until a sequence forms.
6. **Topic cards.** When enough slips gather around one topic and it seems to stay, put them
   behind a tabbed index card of the same size, with the topic's name. His trays came to hold
   four or five hundred of these. Coloured tabs and stars added confusion; he kept that
   information elsewhere.
7. **The working piles.** Besides the topics, five piles:

   | Pile | What goes in it |
   |---|---|
   | UNASSIMILATED | a new idea that interrupts what you are doing; it waits until there is time for it |
   | PROGRAM | "instructions for what to do with the rest of the slips", one slip for each instruction; write one for what you are doing now |
   | CRIT | a slip written in a bad mood, against something; it waits for a calmer day |
   | TOUGH | a slip that seems important but fits no topic yet |
   | JUNK | a slip that "seemed of high value" when written and now seems awful; drop duplicates, keep the rest, because "the junk pile is a working category" and slips come back from it |

**[ANALYSIS]** This is not the Zettelkasten of `notes/`. `SMART_NOTE_POLICY.md` follows
Luhmann as Ahrens describes him: each note has a permanent id and links to other notes. A
Pirsig slip has no id and no link. Its place in the tray is its meaning, and the place changes
every time the slips are sorted. Keep the two apart: do not give a slip an id, and do not hold
the trays in the repository.

## What the agent does

The agent never stands in for the paper. It does not keep a digital copy of the trays, and it
does not sort the owner's slips for them in secret. It does five things, each when asked.

### 1. Cut a text into slips to copy by hand

Input: a message, a dump, a chapter, a conversation.

1. Split it into ideas: one idea, one slip. A slip holds at most about 40 words, what fits on
   four by six inches in a clear hand.
2. Write each slip in plain words. Keep a quotation exact, with its source on the slip.
3. Put on each slip, at the top, one suggested pile or topic in capitals (`UNASSIMILATED` when
   unsure). The owner decides where it goes; the suggestion is pencil, not ink.
4. Do not number the slips and do not put them in order. Order is the owner's later work
   (method, point 4).
5. Give them as a plain list in the reply, one block per slip, ready to copy. If the owner wants
   to print and cut them, lay them out four by six inches on a page and use the `print` skill's
   steps for the PDF; do not commit the PDF.

### 2. Read photos of slips

Input: photos or scans of paper slips.

1. Transcribe each slip as it is, in its own words and language. Do not correct it. Mark a word
   you cannot read as `[illegible]`; never guess it.
2. Note the pile or topic card it sits behind, when the photo shows it.
3. Give the transcript back in the reply. It is a reading aid, not a second set of trays: do not
   commit it unless the owner asks for one slip to become a note (step 5).

### 3. Ask which comes first

Input: some slips, as text or photos, and a topic.

1. Show two slips and ask the owner which comes first. Then the next against the last placed,
   as in the book (method, point 5). Ask one pair at a time.
2. If the owner asks for a proposal, propose an order with one line of reason for each move,
   and mark it **[ANALYSIS]**. The owner moves the paper.

### 4. Name the piles

When the owner sends a pile without a place, suggest for each slip: a topic card that already
exists, a new topic card (only when several slips gather round it), or one of the five working
piles. Say why in a few words. A slip that fits nothing is `TOUGH`, not forced into a topic.

### 5. File a slip as a note

Only when the owner names the slip. Use `/note` (`.claude/commands/note.md`) and
`SMART_NOTE_POLICY.md` as for any note: a `fleeting` note, the slip's words in the body, and
`source: "Matheus Hoffmann, paper slip, <pile or topic>, <date>"`. The note gets an id; the slip
on paper stays where it is. A factual claim on the slip is `unverified` until a source is
fetched, as rule 7 of the policy says.

## Do not

- Do not invent a slip, a pile or a topic card that the owner did not write or ask for.
- Do not quote *Lila* beyond what this page quotes without checking the text first: the book is
  in copyright (Pirsig died in 2017), so `works/` cannot hold it (`ouro-get`). Cite it with its
  chapter.
- Do not cite *Lila* in the paper from this page. A page of the book cites the book, after the
  check that `REFERENCES.md` records.
- Do not turn the slips into an app, a database or a folder of files. The method is paper.

## Sources

Written for this repository on 25 October 2026. Nothing here is copied from another skill.

- Robert M. Pirsig, *Lila: An Inquiry into Morals* (New York: Bantam, 1991), chapter 2. The
  quotations and the facts of "The method, from the book" are from this chapter. They were
  read on 25 October 2026 in two extracts, not in a copy of the book:
  - James Lawley, "Zen and the art of bottom-up modelling", cleanlanguage.com, March 2025
    (<https://cleanlanguage.com/zen-and-the-art-of-bottom-up-modelling/>), which reproduces
    the passage from the Black Swan edition (London, 1992), pages 32 to 39;
  - Andy Matuschak, "Lila - Robert Pirsig", his working notes
    (<https://notes.andymatuschak.org/z7bj6Y9joR2U7KhkazksegZ>), excerpts marked "ch 2".

  Both give "about eleven thousand", the five working piles and the pair question. Status:
  partial. Check each quotation against a printed copy before it goes into the book.
- Pirsig's life and the year of *Lila*: [`BIO_ROBERT_PIRSIG.md`](../../../BIO_ROBERT_PIRSIG.md).
- The Luhmann slip box this method is set against: [`SMART_NOTE_POLICY.md`](../../../SMART_NOTE_POLICY.md).

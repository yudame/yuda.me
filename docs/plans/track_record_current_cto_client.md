# Plan: add a new CTO client to the track record as a current engagement

Request (Tom, 2026-11-05): a new client, Tom serves as CTO, the same
seat as an existing CTO client; started September 2026, ongoing. Update
the site so the new client appears as a current engagement the way the
existing one does.

This record names no client: the repository is public. The client's
name, website and copy live on the site itself
(`src/track-record/index.html`, the first card).

## What is true and public today

Two months in, there is no public outcome. The copy says only:

- the role and period: CTO, 2026 to present (cards show years only);
- what the client's product is, from its own public website and its
  App Store listing (a mental training app for athletes, built by
  coaches and sport psychologists, adapting to the athlete's sport and
  goals, for focus and confidence);
- what Yudame does, in general terms: holds the CTO seat and leads
  engineering on the app, the platform behind it, and the company
  website.

No results, metrics, users, customers, roadmap, people, product
internals or anything from private meetings. The card has no Result
field; it gains one when there is a public outcome to state.

## Build

1. **Logo.** A new file under `assets/logos/clients/`: the client's
   App Store icon at 200x200 PNG (white mark on black, the client's own
   colours). The client's own website header logo is a white-only
   wordmark on transparent and unusable on a light card.
2. **Track-record card** in `src/track-record/index.html`, first in the
   list (newest by start date: September 2026, after the client that
   was on the page by June 2026). Same markup as the existing CTO
   client's card: an `id` anchor, header link to the client's website,
   name, site, and role "CTO · 2026–present".
   - Outcome line, context, and what we did: only the public facts
     above, in the card's usual three parts.
   - Tags: Mobile app · Mental training · Sport psychology.
   Final wording may be tightened in build; it may not add a claim.
3. **Counts, five to six**, and drop "consecutive" (three engagements
   now run at once):
   - track-record meta description: "six client engagements in the
     engineering leadership seat, from seed-stage AI platforms to a
     NASDAQ-listed acquisition."
   - track-record hero lede: "Six client engagements."
   - `src/pacific-telecom/index.html`: "Our last six client
     engagements…". Its "each one ended with the client owning what we
     built" is already untrue (three are ongoing); it becomes "and on
     each one the client owns what we built."
4. **Homepage** `src/index.html`:
   - hero (as built, after Tom asked to simplify it, then for logos):
     no sub-line; under the headline, "Leading Engineering at:" then
     one widely spaced full-colour row of 32px logos, seven in all
     (`.hero-clients`), in card order, newest first, each linking to
     its card; the acquired client shows its own mark and the
     acquirer's, both linking to its card; the one pale-on-white mark
     takes a thin outline (`.is-outlined`). Up to 820px the label sits
     alone on line 1 and the logos on line 2, dropping from the end
     below 512px, 440px and 368px, where n logos need n*32 + (n-1)*40
     px; the acquisition stays in the Engineering leadership card
     below;
   - Engineering leadership card: the new client added first to the
     "Most recently at …" list.

Swept already: no JSON-LD, sitemap or other meta lists or counts
engagements; `security/` mentions engagements only generically; the
og/twitter descriptions name none.

## Out of scope

- Any client outcome or metric (none is public).
- Redesigning the card or making the Result field optional in CSS: the
  fields grid already lays out two fields.
- The client's own website (separate work).
- A GitHub issue: this task can't open one; the plan is the record.

## Verification

No test suite exists for this static site; checks are build and
inspection:

- `npm run build` succeeds.
- Every homepage link to the new card's anchor has a matching `id`;
  every other `#anchor` link on the homepage still resolves.
- `grep -ri "five\b\|consecutive" src/` returns no engagement count.
- No email address added (`grep -rE "[a-z]+@[a-z]+\." src/`).
- Logo renders at 44px, loads (200 response from the dev server), and
  carries alt text.
- Card order newest first by start date.
- Yellow still at full strength once per page (no new `.accent` beyond
  the card's outcome phrase, matching other cards).
- Screenshots, before (from `main`) and after: homepage hero at
  desktop width, the new card at desktop and mobile widths.
- Each claim on the card traced to the client's website or App Store
  listing in the delivery.
- Cleanup: remove `dist/` and `node_modules/` and any screenshot
  server after the run.

## Rounds

Stakes: public copy about a client goes live on merge; reversible by a
revert, but a wrong claim is seen first. Critique 0, review 1 (the
review checks every claim against the public sources and the charter).

## Build notes (after critique)

- Copy rewritten to use only words traceable to the client's website
  and App Store listing. Contrast framing and "daily" dropped; the tag
  "AI coaching" replaced with "Mental training". The accent covers a
  short phrase only: `.accent` is inline-block, so a longer phrase
  wrapped as a block and left the full stop on its own line on mobile.
- Source of record: tomcounsell.com/resume.html (fetched 2026-11-05)
  does not list the new client yet. Contract basis is Tom's own word
  in the team chat (new client, CTO, from September 2026). Flagged in
  the delivery.
- Two-field card at desktop: the fields sit left in the first two of
  three columns, leaving whitespace to the right. Read as deliberate in
  the screenshot; no CSS change.

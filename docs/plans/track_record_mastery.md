# Plan: add Mastery to the track record as a current CTO engagement

Request (Tom, 2026-11-05): Mastery is a new client, Tom serves as CTO,
same as PsyOptimal; started September 2026, ongoing. Update the site so
Mastery appears as a current engagement the way PsyOptimal does.

## What is true and public today

Two months in, there is no public outcome. The copy says only:

- the role and period: CTO, 2026 to present (cards show years only);
- what Mastery is, from its own public site (masteryhq.io, titled
  "Mastery Mental Training") and its App Store listing ("The Mastery
  App": mental training for athletes, built by coaches and sport
  psychologists, adapting to the athlete's sport and goals, for focus
  and confidence);
- what Yudame does, in general terms: holds the CTO seat and leads
  engineering on the app, the platform behind it, and the company
  website.

No results, metrics, users, customers, roadmap, people, product
internals or anything from private meetings. The card has no Result
field; it gains one when there is a public outcome to state.

## Build

1. **Logo.** `assets/logos/clients/mastery.png`: the App Store icon at
   200x200 PNG (white mark on black, Mastery's own colours, like
   Cyndra's black tile). Source:
   `https://is1-ssl.mzstatic.com/image/thumb/Purple211/v4/fe/a3/5f/fea35f19-f5e1-dc52-c1dd-742711850c62/AppIcon-0-0-1x_U007ephone-0-1-85-220.png/200x200bb.png`
   (from `itunes.apple.com/lookup?id=6739948900`). The site's own
   header logo is a white-only wordmark on transparent and unusable on
   a light card.
2. **Track-record card** in `src/track-record/index.html`, first in the
   list (newest by start date: September 2026, after Cyndra, which was
   on the page by June 2026). Same markup as PsyOptimal's:
   `id="mastery"`, header link `https://www.masteryhq.io`, name
   "Mastery", site "masteryhq.io", role "CTO · 2026–present".
   - Outcome line: "Athletes train their bodies every day. Mastery
     gives them <accent>the same daily training for the mind</accent>."
   - Context: "Athletes train their bodies every day and their minds
     rarely. Mastery is a mental training app built by coaches and
     sport psychologists. It adapts to each athlete's sport and goals
     and trains focus and confidence."
   - What we did: "Yudame holds the CTO seat. We lead engineering on
     the app, the platform behind it, and the company website."
   - Tags: Mobile app · AI coaching · Sport psychology.
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
     no sub-line; under the headline, "Leading Engineering at:"
     then one widely spaced full-colour row of 32px logos for all six
     track-record clients (`.hero-clients`), newest first, each linking
     to its card (the new one to `/track-record/#mastery`; Bumble's to
     `#official`); on a phone at most two lines, logos dropping from
     the end below 368px and 345px (the widest at which two lines at 2.5rem spacing cannot hold them);
     the acquisition stays in the Engineering leadership card below;
   - Engineering leadership card: "Most recently at Mastery, Cyndra AI,
     PsyOptimal, and Fuse, and at Official through its acquisition by
     Bumble Inc."

Swept already: no JSON-LD, sitemap or other meta lists or counts
engagements; `security/` mentions engagements only generically; the
og/twitter descriptions name none.

## Out of scope

- Any client outcome or metric (none is public).
- Redesigning the card or making the Result field optional in CSS: the
  fields grid already lays out two fields.
- Mastery's own site (separate work).
- A GitHub issue: this task can't open one; the plan is the record.

## Verification

No test suite exists for this static site; checks are build and
inspection:

- `npm run build` succeeds.
- Every `/track-record/#mastery` link has a matching `id="mastery"`;
  every other `#anchor` link on the homepage still resolves.
- `grep -ri "five\b\|consecutive" src/` returns no engagement count.
- No email address added (`grep -rE "[a-z]+@[a-z]+\." src/`).
- Logo renders at 44px, loads (200 response from the dev server), alt
  text "Mastery logo".
- Card order newest first: mastery, cyndra, psyoptimal, fuse,
  official, simplenight.
- Yellow still at full strength once per page (no new `.accent` beyond
  the card's outcome phrase, matching other cards).
- Screenshots, before (from `main`) and after: homepage hero at
  desktop width, the Mastery card at desktop and mobile widths.
- Each claim on the card traced to masteryhq.io or the App Store
  listing in the delivery.
- Cleanup: remove `dist/` and `node_modules/` and any screenshot
  server after the run.

## Rounds

Stakes: public copy about a client goes live on merge; reversible by a
revert, but a wrong claim is seen first. Critique 0, review 1 (the
review checks every claim against the public sources and the charter).

## Build notes (after critique)

- Copy rewritten to use only words traceable to masteryhq.io ("mental
  and emotional strength training") and the App Store listing ("helps
  athletes train their minds like they train their bodies"; "built by
  elite coaches, sport psychologists"; "adapts to your goals, sport";
  "focus, confidence"). Contrast framing and "daily" dropped. Tag "AI
  coaching" replaced with "Mental training". The accent covers "train
  their minds" only: `.accent` is inline-block, so a longer phrase
  wrapped as a block and left the full stop on its own line on mobile.
- Source of record: tomcounsell.com/resume.html (fetched 2026-11-05)
  lists PsyOptimal and Cyndra as CTO, not Mastery yet. Contract basis
  is Tom's own word in the team chat (new client, CTO, from September
  2026). Flagged in the delivery.
- Two-field card at desktop: the fields sit left in the first two of
  three columns, leaving whitespace to the right. Read as deliberate in
  the screenshot; no CSS change.

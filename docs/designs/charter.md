# Design System Charter — yuda.me

> The contract every design change to this site is tested against.
> If the company's voice or constraints change, update this file
> FIRST, then change the site. Derived 2026-06-12 from the Yudame
> Research charter (`~/src/cuttlefish/docs/designs/charter.md`);
> this is the corporate-site sibling, not a copy.

## Positioning

yuda.me is the corporate surface of Yudame — a US-incorporated,
Thailand-headquartered product engineering studio serving development
banks, governments, and operators across Asia and the Pacific. The
reader is an institutional evaluator: an ADB officer, a vendor
due-diligence reviewer, a telecom executive. They are time-pressed,
skeptical of vendor theater, and fluent in procurement.

The site should read like the firm it describes: precise, convicted,
unhurried. Editorial restraint says *you are in capable hands*;
specificity and honesty say *we have nothing to hide*. The Yudame
family of surfaces (this site, Yudame Research) shares one editorial
voice — same typefaces, different accent.

## Principles

1. **Honest, not clever.** No decorative flourish without a
   structural reason. Placeholders are designed, labeled states —
   never raw brackets.
2. **Editorial over marketing.** No superlatives, no gradients-as-
   identity, no urgency theatrics. The reader is a specialist;
   address them as one.
3. **One committed accent moment per page.** Yellow appears at full
   strength (`#FFC107`) exactly once per page — the primary CTA.
   Everywhere else it is a line, a tick, a dot. Two filled moments
   is one too many.
4. **Whitespace must be earned.** Every section needs ≥3 visual
   anchors (heading, body, CTA/diagram/label). Sparseness
   masquerading as simplicity is the default failure mode.
5. **Every page starts a relationship.** No dead ends: every page
   carries the contact section and the universal footer nav. An
   evaluator who is persuaded always has a next step.
6. **Calm over impressive.** Motion is gentle, short, and respects
   `prefers-reduced-motion`. Nothing pulses for attention.

## Typography

| Font | License | Hosted | Used for |
|---|---|---|---|
| Lora | SIL OFL 1.1 | Google Fonts CDN | all headings h1–h6, weight 500 |
| Inter | SIL OFL 1.1 | Google Fonts CDN | body copy, UI prose |
| IBM Plex Mono | SIL OFL 1.1 | Google Fonts CDN | eyebrows, labels, data, button text |

Weights loaded: Lora 500 (+italic) · Inter 300/400/500/600 ·
IBM Plex Mono 400/500. No fourth face without amending this table.
Raleway is retired (2026-06-12) — remove, don't extend, any
remaining references.

- Hierarchy comes from size and leading, not typeface swap within a
  role. Serif never appears in buttons, labels, or UI chrome.
- Mono is signal, not texture: eyebrows, status chips, field labels,
  button text. Long-form copy is always Inter.
- Eyebrow convention: mono, uppercase, letter-spaced
  (`PRACTICE_AREA`, `CASE_STUDIES`). Labels name; body copy sells.

## Color

| Token | Value | Role |
|---|---|---|
| `--yellow` | `#FFC107` | the accent. Underlines, ticks, status dots, and the one filled CTA per page |
| `--black` | `#0a0a0a` | text, the contact band background |
| `--white` | `#ffffff` | page background |
| `--warm-gray` | `#fafafa` | alternating section bands |
| `--text-gray` | `#666666` | secondary text (4.5:1+ on white) |

The desaturated `#f5d563` is retired. Yellow is never a text color
on white. The black contact band is the only dark surface; yellow
on `#0a0a0a` (CTA) and white on `#0a0a0a` both clear WCAG AA.

## Voice & tone

- Sentence case body; mono UPPERCASE only where a label is the point.
- Avoid: emoji, exclamation marks, "simply", "easy", marketing
  superlatives, second-person salesmanship.
- Button labels: uppercase mono, imperative, ≤3 words —
  "START A CONVERSATION", "EMAIL US". Never "Learn more".
- Confidentiality ceilings (Pacific pages) override every other
  rule: regional framing only until partners launch publicly.
- Pending content is a feature, not an apology: designed status
  chip + a plain-language promise of when detail lands.

## Structure

- One stylesheet: `src/styles.css` (Tailwind input; shared design
  system CSS lives after the directives). Pages carry NO inline
  `<style>` blocks. If a rule is needed twice, it lives in the
  stylesheet; if needed once, it still does.
- Universal footer on every page: nav (Case Studies · Pacific
  Telecom · Security) + copyright. No dead-end pages.
- Back-link convention: top-left, arrow + "Yudame", on every
  subpage, identically.
- Contact section (black band, Lora heading, one yellow CTA,
  `hello@yuda.me`) precedes the footer on every page.

## Do's and don'ts

- ✅ **Do** use yellow at full strength exactly once per page.
- ❌ **Don't** ship a thick colored border on ONE side of a
  multi-line container — the canonical AI-UI tell. 1px full border
  or tinted bg, never both, never one-sided.
- ❌ **Don't** ship plausible-but-empty stats ("100% verified").
  If a number isn't real and actionable, don't display it.
- ❌ **Don't** ship inert heroes. Every top-of-page section has a
  visible CTA or scroll affordance.
- ❌ **Don't** ship raw placeholder text ("[metric pending]").
  Pending states are designed and labeled.
- ❌ **Don't** animate non-clickable elements on hover. Hover motion
  (lift, shadow, border change, scale) is a click affordance —
  reserve it for links and buttons. A static card that reacts to
  the cursor is promising an interaction it can't deliver.
- ✅ **Do** keep accessibility floors: 2px yellow focus ring on a
  dark offset, `prefers-reduced-motion` honored, body contrast
  ≥4.5:1, tap targets ≥44px.

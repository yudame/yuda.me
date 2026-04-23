---
status: Planning
type: feature
appetite: Medium
owner: Valor
created: 2026-04-23
tracking: https://github.com/yudame/yuda.me/issues/7
last_comment_id:
---

# Case Studies Surface (Outcome-First)

## Problem

Development-sector buyers — ADB task managers, regulated telecoms, government procurement teams — evaluate vendors on delivered development outcomes, not tech stack. Yudame's site today has zero case-study surface: `src/index.html` is the only page, and partnerships are described abstractly ("Partnerships are thoughtfully chosen") with no specific engagements. An evaluator who lands on yuda.me during a vendor shortlist finds no proof of delivered impact and no sector/region signal. The site's positioning push for ADB / DMC / Pacific (issues #5, #6, #9) is a promise the site can't currently back up.

**Current behavior:** Single-page site with no case studies, no outcomes, no sector signals. Prospect bounces or lowers trust.

**Desired outcome:** A case-studies surface on yuda.me — either a homepage section or a dedicated `/case-studies` page — that lists engagements framed around development outcomes (users reached, inclusion metrics, capacity built) with tech stack subordinated. Structure ships with at least one placeholder entry; full content is a follow-up.

## Freshness Check

**Baseline commit:** `9bd7765` (Revert "Migrate domain from yuda.me to yudame.org")
**Issue filed at:** 2026-04-23T10:11:48Z (today)
**Disposition:** Unchanged — filed today, no drift.

**File:line references re-verified:**
- `src/index.html` — confirmed single-page, no case-studies surface. Structure: Hero -> Philosophy -> Capabilities -> About -> Footer.
- `assets/` — contains `logos/` and `profiles/` only; no `case-studies/` directory. Greenfield.
- `.github/workflows/deploy.yml` — builds via `npm run build` and deploys `./dist`. `npm run copy:html` uses `cp -r src/*.html dist/`, so any new HTML file in `src/` is automatically included.

**Cited sibling issues/PRs re-checked:**
- #5 (ADB 2026 positioning brief) — open, labeled documentation. Parallel-planned. Build-time prerequisite (supplies outcome vocabulary).
- #6 (Homepage reposition) — open, labeled enhancement. Parallel-planned. Coordinates on surrounding copy tone.
- #9 (Pacific telecom practice page) — open, labeled enhancement. Parallel-planned. Open question on where the Pacific placeholder lives (see Open Questions).

**Commits on main since issue filed:** None.
**Active plans in `docs/plans/` overlapping this area:** `rebuild.md` exists but is unrelated (site-wide rebuild history). Parallel plans for #5/#6/#8/#9 are being authored in the same batch — coordination via this plan's Open Questions section.
**Notes:** Phase 0.5 is trivial per the prompt; no drift to incorporate.

## Prior Art

- No prior case-studies content in git history. A QuickBooks sub-page existed earlier (commit `1cc0e68`) but was deliberately removed; the site has been single-page since. Adding a new page is an editorial reversal that must be justified by volume of entries.
- No closed issues or merged PRs for case studies exist in the repo — this is a greenfield surface.

## Research

Skipped — work is purely internal (static HTML + Tailwind, no new libraries, APIs, or ecosystem patterns). Outcome-framing vocabulary will come from issue #5's positioning brief, not from WebSearch.

## Data Flow

Static-site content surface; data flow is authoring-to-render:

1. **Authoring:** Editor writes case-study entry markup directly in `src/index.html` (Option A) or a new `src/case-studies.html` (Option B).
2. **Build:** `npm run build` runs Tailwind build, then `cp -r src/*.html dist/` copies HTML, then `cp -r assets dist/`.
3. **Deploy:** GitHub Actions workflow (`.github/workflows/deploy.yml`) uploads `./dist` as a Pages artifact on push to `main`.
4. **Render:** Visitor requests `yuda.me` (or `yuda.me/case-studies.html` in Option B); GitHub Pages serves the static file.

No new data stores, APIs, or runtime logic. The only data-integrity concern is confidential-client information leaking into committed HTML — see Risks.

## Architectural Impact

- **New dependencies:** None. Pure HTML/CSS additions within the existing Tailwind + inline `<style>` system.
- **Interface changes:** If Option B (dedicated page), adds a second HTML route (`/case-studies.html`) and a link from the homepage. If Option A (section), no route changes.
- **Coupling:** Low. Case studies surface is self-contained content; no code dependencies on other sections.
- **Data ownership:** Editorial content lives in the HTML file. Future migration to a content-managed source (e.g., Markdown collection, CMS) is deferred.
- **Reversibility:** Trivial. Either option can be removed by reverting a single commit.

## Appetite

**Size:** Medium

**Team:** Solo dev + designer review (visual aesthetic consistency is non-negotiable)

**Interactions:**
- PM check-ins: 1–2 (section-vs-page decision; Pacific-placeholder location decision)
- Review rounds: 1 (design review before merge — confirm visual fidelity)

Medium appetite reflects communication overhead, not coding time. Implementation is a few hours of HTML/CSS; the surface area for coordination (confidential-client constraint, parallel issue planning, section-vs-page choice) is what earns the Medium sizing.

## Prerequisites

| Requirement | Check Command | Purpose |
|-------------|---------------|---------|
| Node 20+ installed | `node --version` | Run build/dev |
| Dependencies installed | `test -d node_modules` | Tailwind and build scripts |
| Issue #5 outcome vocabulary available (soft) | `test -f docs/plans/adb_2026_positioning_brief.md` | Framing guidance; not a hard blocker |

## Solution

### Key Elements

- **Case study card** — Repeatable structural unit with five zones: outcome headline, context, what we did, result, tech stack (subordinated).
- **Surface container** — Either a `<section class="case-studies">` on the homepage or a standalone `src/case-studies.html` page.
- **Homepage link** — If Option B, a footer-adjacent link from `index.html` to the case-studies page.
- **Placeholder treatment** — Visually complete card for the unnamed Pacific telecom engagement, marked "details pending public launch." No logo, no country, no subscriber count, no hint that could single the client out.

### Flow

**Homepage (Hero → Philosophy → Capabilities → [new: Case Studies] → About → Footer)** → visitor scrolls or clicks "See our work" → reads outcome headlines → optionally reads full card → CTA to contact or (eventually) practice page.

Option B alternative flow:
**Homepage** → visitor clicks "Case studies" link (placed near the work-links section or in footer) → `/case-studies.html` → reads entries → returns or closes tab.

### Technical Approach

- **Styling:** Reuse existing CSS custom properties (`--yellow`, `--black`, `--warm-gray`, `--text-gray`) and the established typography scale (h2 `clamp(1.75rem, 4vw, 2.5rem)`, Inter 300-weight headings). Case-study cards should visually echo the existing `.capability-card` pattern (1px border, hover lifts to `--yellow` border, translateY on hover) so the surface feels native.
- **Section placement (Option A):** Insert a new `<section class="case-studies">` between Capabilities and About. Background alternates: Capabilities is white, About is `--warm-gray`, so case-studies should be white (to preserve alternating rhythm) or `--warm-gray` with About shifted to white — pick whichever reads better in the mocked layout.
- **Page placement (Option B):** Create `src/case-studies.html` using the same `<head>` block, fonts, and inline `<style>` approach as `index.html`. Extract shared styles into `src/styles.css` (the Tailwind input) only if both files need them — avoid premature factoring.
- **Card structure (HTML):**
  ```html
  <article class="case-study">
    <p class="case-study-outcome">[Outcome headline with numbers]</p>
    <h3 class="case-study-title">[Short descriptor — region + sector, never identifying]</h3>
    <p class="case-study-context">[Who, where, what problem]</p>
    <p class="case-study-action">[What we did]</p>
    <p class="case-study-result">[Measurable outcomes + capacity left with client]</p>
    <p class="case-study-stack">[Tech stack — small, muted, bottom]</p>
  </article>
  ```
  Outcome headline gets the largest type; tech stack gets the smallest and a muted color.
- **Placeholder copy (Pacific entry — confidentiality-safe):**
  - Outcome: "Building resilient mobile financial infrastructure for an underserved market."
  - Title: "Pacific telecom operator — details pending public launch."
  - Context/action/result: structurally present but deliberately generic. No country, no subscriber count, no partner bank, no product category that narrows identity. See Risks for explicit do-not-say list.
- **Build pipeline:** If Option B, verify `npm run copy:html` picks up the new file (it uses `src/*.html`, so yes). Test locally with `npm run dev` and confirm `dist/case-studies.html` exists after `npm run build`.
- **Accessibility:** Maintain heading hierarchy (case-study section gets an `h2`; each card uses `h3`). Focus outline uses existing `--yellow` 2px style. Reduced-motion media query already handles hover transitions.

## Failure Path Test Strategy

### Exception Handling Coverage
- No exception handlers in scope — this is static HTML. "Failure" here means broken build or rendering, not runtime exceptions.

### Empty/Invalid Input Handling
- N/A — no user input processed. Authoring errors (e.g., missing card fields) are caught by visual review and the placeholder-safety checklist in Risks.

### Error State Rendering
- N/A — no dynamic error states. Visual review covers layout failure modes (stacked cards on mobile, overflow on long outcome headlines).

## Test Impact

No existing automated tests in this repo. Validation is manual:

- Visual QA at three breakpoints (mobile ~375px, tablet ~768px, desktop ~1280px) via `npm run dev`.
- Build smoke: `npm run build` then inspect `dist/` for expected files.
- Link smoke: if Option B, confirm homepage link navigates to the new page and back.
- Confidentiality pass: explicit read-through against the do-not-say list in Risks before merge.

## Rabbit Holes

- **Building a generic case-study content model.** Tempting to build a Markdown collection, JSON manifest, or mini-CMS. Don't. With 1–3 entries, inline HTML is faster to author and easier to review for confidentiality leaks.
- **Redesigning the homepage to accommodate the new section.** Out of scope; issue #6 handles homepage copy. This plan adds a surface, it doesn't restructure the page.
- **Writing narrative content for real past engagements.** Explicitly deferred per the issue's Revised scope. This plan ships structure + placeholder.
- **Logo walls, testimonial quotes, client-named callouts.** All tempting social-proof additions. None belong here yet — confidentiality constraint on the current live engagement means any named proof would look sparse by comparison.
- **Filter/search/tag UI.** Premature. At 1–3 entries, listing is fine.

## Risks

### Risk 1: Confidential client identity leaks into the Pacific placeholder
**Impact:** Contractual and reputational damage. Client is a Pacific telecom operator currently under active delivery; naming, logo-ing, or uniquely-identifying them publicly before their launch would be a breach. Partial hints ("800k-subscriber carrier," "national mobile money rollout," country name) are as dangerous as a full name — a motivated reader narrows it in one search.
**Mitigation:**
- Hard do-not-say list (all prohibited in placeholder copy, alt text, filenames, and commit messages):
  - Client name, product name, partner bank/agency name.
  - Country, island group, or any geographic narrower than "Pacific."
  - Subscriber count, transaction volume, deployment dates, or launch dates.
  - Logo file, favicon, or any visual mark.
  - Product category that uniquely identifies (e.g., specific mobile money product names).
- Ceiling of specificity: **"Pacific telecom operator — details pending public launch."** That exact phrasing is the most identifying text permitted.
- Pre-merge confidentiality pass: dev reads the full cards + commit message diff against the do-not-say list. A second reviewer (Tom) confirms before merge.
- No entry in `assets/case-studies/` for this client at launch — no image means no accidental logo leak.

### Risk 2: Visual aesthetic drifts from the rest of the site
**Impact:** The homepage has a deliberate minimalist aesthetic (thin-weight Inter, generous whitespace, subtle yellow accents, 1px borders with hover lift). A mismatched case-studies surface would read as bolted-on and undermine credibility at the exact moment we're trying to establish it.
**Mitigation:** Reuse `.capability-card` as the visual template. No new colors, no new fonts, no new border radii. Design review before merge is explicitly required (see Appetite).

### Risk 3: Section-vs-page decision is made without thinking about #9
**Impact:** Issue #9's planner is deciding simultaneously whether the Pacific placeholder lives on the practice page. If both issues independently decide "yes, here" we get duplicate cards; if both decide "no, not here" we get no placeholder at all. Either is worse than one deliberate call.
**Mitigation:** Surfaced as Open Question 2 below. Do NOT silently pick a location. The user batches the decision across #7 and #9.

### Risk 4: Build pipeline misses a new HTML file
**Impact:** (Option B only) Page builds locally but 404s in production.
**Mitigation:** `npm run copy:html` already uses `src/*.html`, so any new file is picked up. Pre-merge smoke: run `npm run build` and confirm `dist/case-studies.html` exists.

## Race Conditions

No race conditions identified — static HTML, synchronous build pipeline, single-writer authoring.

## No-Gos (Out of Scope)

- **Writing real case-study narratives for past engagements.** Follow-up issues, one per engagement.
- **Content management system or Markdown ingestion.** Not at this volume.
- **Client logo wall.** Not until we have permission-to-name for enough clients to justify it.
- **Testimonial quotes.** Deferred; requires separate sign-off per client.
- **Tagging / filtering / search UI.** Premature.
- **Migration to a multi-page site architecture beyond this one page.** Option B adds exactly one page; broader IA is out of scope.
- **Changes to `index.html` copy tone.** That's issue #6.
- **Pacific practice-page content.** That's issue #9.

## Update System

No update system applies — this is a static site deployed by GitHub Actions. No bridge service, no multi-machine rollout.

## Agent Integration

No agent integration — yuda.me is a public marketing site, not part of the Valor agent surface.

## Documentation

### Feature Documentation
- [ ] No `docs/features/` directory convention exists in this repo (verified — repo has `docs/plans/` only). Skip unless issue #6's plan introduces the convention; if so, add a minimal entry then.

### External Documentation Site
- N/A — no docs site.

### Inline Documentation
- [ ] HTML comment at the top of the case-studies section/page explaining the outcome-first convention for future editors.
- [ ] HTML comment on the placeholder card flagging the confidentiality constraint so a future editor doesn't "helpfully" add detail.

## Success Criteria

- [ ] Case-studies surface exists, either as a homepage section or a dedicated `/case-studies.html` page (decision recorded in plan before build).
- [ ] Surface is linked from the homepage (new section is in-page; new page is linked near work-links or footer).
- [ ] At least one entry renders: the Pacific placeholder, structurally complete and confidentiality-safe.
- [ ] Outcome-first framing is visible: outcome headline leads every card; tech stack is subordinated (smaller, muted) or omitted.
- [ ] Copy contains no tech-first language ("we built an X app"); leads with user/client impact.
- [ ] Placeholder card contains **zero** items from the Risk 1 do-not-say list. Confirmed by pre-merge confidentiality pass.
- [ ] Visual aesthetic matches existing homepage: Inter 300/500, existing CSS custom properties, `.capability-card`-style borders and hover, no new design tokens introduced.
- [ ] `npm run dev` renders cleanly at mobile, tablet, desktop breakpoints with no layout breakage.
- [ ] `npm run build` succeeds and (if Option B) `dist/case-studies.html` exists.
- [ ] Design review signoff from second pair of eyes before merge.

## Team Orchestration

Solo execution. No sub-agent orchestration required for a change this small; tracking as a single builder task for consistency with the skill template.

### Team Members

- **Builder (case-studies-surface)**
  - Name: cs-builder
  - Role: Author the HTML/CSS for the case-studies surface per the chosen option, implement the Pacific placeholder, verify build.
  - Agent Type: builder
  - Resume: true

- **Validator (case-studies-surface)**
  - Name: cs-validator
  - Role: Run confidentiality pass against the do-not-say list, verify visual fidelity at three breakpoints, verify build output.
  - Agent Type: validator
  - Resume: true

## Step by Step Tasks

### 1. Resolve section-vs-page decision
- **Task ID**: decide-surface-type
- **Depends On**: Open Question 1 answer from user
- **Assigned To**: Valor (pre-build)
- **Parallel**: false
- Record decision in this plan (update Solution section, strike the unused option).
- If Option B, also confirm Open Question 2 answer from user about Pacific-placeholder location coordination with issue #9.

### 2. Build the surface
- **Task ID**: build-case-studies-surface
- **Depends On**: decide-surface-type
- **Assigned To**: cs-builder
- **Agent Type**: builder
- **Parallel**: false
- Add the section (Option A) or create `src/case-studies.html` + homepage link (Option B).
- Author the Pacific placeholder card using the exact confidentiality-safe copy from the Technical Approach section. Zero items from the do-not-say list.
- Add HTML comment flagging confidentiality constraint on the placeholder.
- Reuse existing CSS custom properties and `.capability-card`-style hover. No new design tokens.
- Run `npm run dev` locally and check three breakpoints.

### 3. Validate
- **Task ID**: validate-case-studies-surface
- **Depends On**: build-case-studies-surface
- **Assigned To**: cs-validator
- **Agent Type**: validator
- **Parallel**: false
- Confidentiality pass: read card copy + alt text + commit message against Risk 1 do-not-say list. Zero hits required.
- Visual pass: screenshots at 375px / 768px / 1280px.
- Build pass: `npm run build`; if Option B, confirm `dist/case-studies.html` exists.
- Outcome-first pass: confirm outcome headline is the first and largest element in every card, tech stack is the last and smallest.

### 4. Design review
- **Task ID**: design-review
- **Depends On**: validate-case-studies-surface
- **Assigned To**: Tom (human reviewer)
- **Parallel**: false
- Visual fidelity vs. rest of homepage. Approve or request changes.

## Verification

| Check | Command | Expected |
|-------|---------|----------|
| Build succeeds | `npm run build` | exit code 0 |
| (Option B only) Page is in dist | `test -f dist/case-studies.html` | exit code 0 |
| Placeholder contains no prohibited country names | `grep -iE "fiji\|samoa\|tonga\|vanuatu\|solomon\|png\|papua" src/index.html src/case-studies.html 2>/dev/null` | exit code 1 (no matches) |
| Placeholder contains no subscriber-count numbers | `grep -iE "[0-9]+(k\| thousand\| million) subscribers" src/index.html src/case-studies.html 2>/dev/null` | exit code 1 (no matches) |
| Outcome-first marker present | `grep -c "case-study-outcome" src/index.html src/case-studies.html 2>/dev/null` | output > 0 |

## Critique Results

<!-- Populated by /do-plan-critique. Leave empty until critique is run. -->

---

## Open Questions

1. **Section vs. dedicated page?** With exactly one placeholder entry at launch, a homepage section (Option A) is the lighter-weight and more defensible choice. A dedicated page (Option B) is editorially heavier but creates a home that scales as real entries land. **Recommendation if no strong preference: Option A (homepage section) now; migrate to Option B when entry count reaches 3.** User call before build.

2. **Where does the Pacific placeholder live — here, on the practice page (#9), or both?** Issue #9's planner is making the symmetric decision simultaneously. Three options:
   - (a) Here only: practice page (#9) links here for the proof point.
   - (b) Practice page (#9) only: this surface launches with a non-Pacific generic placeholder or launches empty until a named case study exists.
   - (c) Both: acceptable if the two cards use different framings (this surface = outcome-focused, practice page = regional-expertise-focused). Risk: confidentiality surface area doubles.
   User should pick one answer that applies to both #7 and #9 plans.

3. **Is there a non-Pacific engagement safe enough to include at launch, even as a second placeholder?** A second entry would make the surface feel less "single placeholder + coming soon." If there's a completed-and-public engagement (even small) we could describe, it strengthens the surface immediately. No action here beyond raising the question.

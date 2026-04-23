---
status: Planning
type: feature
appetite: Medium
owner: Valor
created: 2026-04-23
tracking: https://github.com/yudame/yuda.me/issues/9
last_comment_id:
---

# Pacific Telecom Practice Page

## Problem

An evaluator from ADB's Pacific Department, a Pacific-region carrier's strategy team, or a multilateral procurement officer lands on `yuda.me` today and finds **zero** signal that Yudame operates in the Pacific region or in telecom. The only surface is a single-page homepage with no mention of telecom, the Pacific region, or carrier work of any kind. The fact that Yudame is currently delivering a project for a Pacific telecom operator — a genuine, valuable credential — has no public surface to attach to.

**Current behavior:**
- `src/index.html` is the entire site. It does not mention telecom, the Pacific, DMCs, or carrier work.
- No concept of "practice area" exists in the IA. There is no URL shape (`/practices/*` or `/pacific-telecom`) that future regional or sector pages could share.
- When the current Pacific telecom client launches publicly, there is nowhere structurally appropriate to drop the case study. The team would have to both invent the page and write the case study under launch pressure.

**Desired outcome:**
- A dedicated page at a stable URL (`/practices/telecom` preferred; see Open Questions) that honestly establishes Yudame's Pacific telecom practice area.
- The page describes Yudame's capabilities and the Pacific region but does **not** name, logo, screenshot, or uniquely identify the current client.
- The page includes a structurally-complete placeholder slot for the named case study that will land post-client-launch. The slot reads naturally — a reader who doesn't know there's a pending client sees a coherent "more case studies coming" moment, not a suspicious hole.
- The page ships through the existing build (`npm run build`) and GitHub Pages deploy workflow with no additional infrastructure.

## Freshness Check

**Baseline commit:** `9bd7765` (`Revert "Migrate domain from yuda.me to yudame.org"`)
**Issue filed at:** 2026-04-23T10:11:52Z
**Disposition:** Unchanged — issue filed today, no drift possible.

**File:line references re-verified:**
- `src/index.html` — issue claims no telecom/Pacific content. Verified: grep for `telecom|pacific|practice|fiji|samoa|tonga|vanuatu` returns zero hits. Still holds.
- `package.json` scripts — `build`, `copy:html`, `copy:assets` verified present and functional.
- `.github/workflows/deploy.yml` — verified: runs `npm run build`, uploads `./dist` as Pages artifact.

**Cited sibling issues/PRs re-checked:**
- #5 (ADB 2026 positioning brief) — open, planned in parallel. Vocabulary source.
- #6 (Homepage ADB/DMC/Pacific reposition) — open, planned in parallel. Will link to this page.
- #7 (Case studies surface) — open, planned in parallel. Placeholder-home coordination required — see Open Questions.
- #8 (Security & compliance page) — open, planned in parallel. Unrelated to this work.

**Commits on main since issue was filed (touching referenced files):** None. Issue was filed today.

**Active plans in `docs/plans/` overlapping this area:** Four sibling plans (#5, #6, #7, #8) being written in parallel in this same batch. Overlap with #6 (homepage links here) and #7 (case-study component may live here, there, or both) is deliberate and handled via Open Questions.

**Notes:** Filed today; no drift possible. Baseline captured for reference.

## Prior Art

No prior issues or PRs touch Pacific, telecom, practice areas, or sector pages. The site has never had a sub-page beyond `index.html`. This is greenfield work for the site's IA.

- **Issue #5**: Research ADB 2026 digital priorities — OPEN, parallel. Output feeds vocabulary for this page.
- **Issue #6**: Reposition homepage copy for ADB/DMC/Pacific audience — OPEN, parallel. Homepage will link here.
- **Issue #7**: Add development-outcomes case studies surface — OPEN, parallel. Coordination on placeholder home required.
- **Issue #8**: Add security & compliance page for vendor due diligence — OPEN, parallel. Establishes a sibling page pattern; URL convention decisions should be coordinated.

## Research

Skipped — this is editorial/structural work. Technical stack (Tailwind + static HTML + GitHub Pages) is well-understood and already in the repo. No external libraries, APIs, or ecosystem patterns are being introduced. The substantive research for Pacific telecom vocabulary and ADB framing is scoped to issue #5 and will flow into this page's copy at build time.

## Data Flow

Editorial page, not a data pipeline. A reader's journey:

1. **Entry point**: Reader lands on homepage (`/`) or is linked directly from a partner/proposal (`/practices/telecom`).
2. **Homepage link**: Navigation or body-level link points to `/practices/telecom`.
3. **Practice page render**: Static HTML served from `dist/practices/telecom/index.html` (or `dist/practices/telecom.html`) via GitHub Pages.
4. **Reader engages**: Reads the practice statement, capability framing, and case-study section.
5. **Case-study placeholder**: Reader sees a naturally-worded "more case studies coming" slot — no client identity leak.
6. **Output**: Reader forms an evidence-backed view that Yudame does Pacific telecom work.

## Architectural Impact

- **New dependencies**: None. Uses existing Tailwind + static HTML pipeline.
- **Interface changes**: Introduces first sub-path in the site. Establishes URL convention (`/practices/*`) that #7 and #8 will need to align with.
- **Coupling**: Loose. New page is a sibling of `index.html`, no shared state.
- **Data ownership**: None — fully static content.
- **Reversibility**: Trivial. Delete the file and the link; the site reverts to single-page.

## Appetite

**Size:** Medium

**Team:** Solo dev + human reviewer (confidentiality gate)

**Interactions:**
- PM check-ins: 1–2 (open questions resolution; confidentiality gate review on final copy)
- Review rounds: 1 (mandatory human review of final page copy + PR diff + commit history for client-identification leaks)

The code is small; the confidentiality discipline is the cost. A dedicated review pass is non-negotiable, which is why this is Medium rather than Small.

## Prerequisites

| Requirement | Check Command | Purpose |
|-------------|---------------|---------|
| Node + npm installed | `node --version && npm --version` | Build the site |
| Dependencies installed | `test -d node_modules` | Tailwind build |
| Build succeeds on current main | `npm run clean && npm run build && test -f dist/index.html` | Confirm baseline pipeline works before adding a page |
| Issue #5 vocabulary available (soft) | `test -f docs/plans/adb_2026_positioning_brief.md` | Positioning brief output informs copy — build-time (not plan-time) prerequisite |

## Solution

### Key Elements

- **Practice page** (`src/practices/telecom.html` or `src/practices/telecom/index.html`): Dedicated page with practice statement, capability framing, Pacific-region focus, and a structurally-complete case-study placeholder. Visual aesthetic inherits from `src/index.html`.
- **Build wiring**: Extend `copy:html` to pick up nested HTML files under `src/` so the practice page is emitted to `dist/practices/telecom/...`. Current `cp -r src/*.html dist/` only copies top-level HTML; a nested directory needs explicit handling.
- **Homepage link**: Add a link from `src/index.html` to `/practices/telecom` (placement per #6 coordination).
- **Case-study placeholder component**: A block of HTML structured like a case-study card (heading, summary slot, outcome slot) with placeholder copy that reads naturally without any client-identifying hint. Component stays on the practice page regardless of #7 coordination outcome — it anchors the page's bottom.
- **Confidentiality gate**: A checklist (below) that must be run against all public artifacts before merge.

### Flow

Homepage → "Practices" link → Practice page (`/practices/telecom`) → Read practice statement → Scroll to capabilities → Scroll to case-study placeholder → (future: click through to named case study once client launches)

### Technical Approach

- **URL shape**: Use `/practices/telecom/` (directory with `index.html`) to keep room for sibling practices without URL churn. Coordinates with #7/#8 on a shared `/practices/` or `/{section}/` convention.
- **Page template**: Copy `src/index.html`'s `<head>`, font loading, and Tailwind classes. Maintain `yudame-yellow`, `yudame-red`, `yudame-dark` brand colors and Raleway font family per CLAUDE.md.
- **Build script change**: Update `package.json` `copy:html` from `cp -r src/*.html dist/` to a form that preserves nested structure (e.g., `mkdir -p dist/practices/telecom && cp src/practices/telecom/index.html dist/practices/telecom/` or a `find`-based copy). Keep it explicit rather than glob-deep to avoid silently picking up unintended files.
- **Deploy**: No workflow change needed — `.github/workflows/deploy.yml` already runs `npm run build` and uploads `./dist` wholesale.
- **Copy sourcing**: Draft copy from issue #5's output once available. If #5 is not yet landed at build time, draft conservative "we do X in the Pacific" copy and flag for reviewer.
- **Placeholder wording**: Use generic framing. Forbidden: country names that would single the client out, subscriber counts, launch dates, product names, brand adjacency. Safe: regional framing ("Pacific operators"), category framing ("mobile experience work"), and an explicit "case study forthcoming" label.

## Failure Path Test Strategy

### Exception Handling Coverage
No exception handlers in scope — static HTML has no runtime exception surface.

### Empty/Invalid Input Handling
Not applicable — no user input. The page is a static document.

### Error State Rendering
- [ ] Verify `dist/practices/telecom/index.html` exists after `npm run build`. If the copy step silently fails, Pages would serve a 404 for the new URL.
- [ ] Verify homepage link to `/practices/telecom` does not 404 after deploy.
- [ ] Local `npm run dev` renders the page with styles applied (no bare-HTML Tailwind-missing state).

## Test Impact

No existing tests to update — this repo has no test suite. Verification is manual: visual QA in `npm run dev`, `npm run build` output inspection, and a post-deploy smoke check of the live URL.

The site's lack of automated tests is a separate concern not addressed here.

## Rabbit Holes

- **Building a full CMS or practice-page template engine.** Tempting because "we'll have more practice pages." Don't. Write one page in plain HTML, extract a template only when the second page exists.
- **Writing the named case study.** Blocked by client confidentiality until launch. Do NOT attempt a "thinly disguised" version — that's the exact failure mode the confidentiality constraint exists to prevent.
- **Redesigning the homepage to accommodate a new nav.** #6 owns homepage changes. Add the minimum link and defer IA to #6.
- **Over-coordinating on `/practices/*` URL shape across #7 and #8 right now.** Pick a sensible convention here; #7 and #8 can align with it or explicitly diverge.
- **Designing hover states, interactions, or micro-animations.** Inherit the homepage's aesthetic exactly. No new interaction patterns this round.
- **SEO/meta tag optimization.** Basic `<title>` and `<meta description>` are sufficient. Don't spend a day tuning OpenGraph previews.

## Risks

### Risk 1: Client identification leak in copy, diff, or commit history
**Impact:** Catastrophic. Named disclosure of an unlaunched client engagement breaches the client relationship, potentially terminates the contract, and damages Yudame's reputation with future telecom clients who value discretion.
**Mitigation:**
- Mandatory human review of the page copy against a confidentiality checklist (below) before merge.
- Mandatory review of the PR diff, PR description, and commit messages for any client-identifying strings.
- The plan document itself stays generic — no client name, no country name, no product name anywhere in `docs/plans/pacific_telecom_practice_page.md`.
- Avoid country-level specificity in copy (e.g., "our work in Fiji" is forbidden if the client is the only Pacific carrier Yudame has worked with in Fiji). Use regional framing only.
- Forbid logos, screenshots, or brand adjacency in the placeholder.
- Forbid metrics or subscriber numbers that could uniquely identify the client.
- Do not commit client-identifying strings to any branch — not even a feature branch, since git history is public.

### Risk 2: Placeholder reads as suspicious "something is being hidden here"
**Impact:** Medium. A savvy reader notices a "case study coming soon" block and infers "they have a client they can't talk about" — which is itself a mild identity leak (narrows the field of possible clients).
**Mitigation:**
- Frame the placeholder as a general "more case studies forthcoming" posture, not a single slot with visible scaffolding around one missing item.
- If the case-studies surface (#7) is also placeholder-heavy at launch, the symmetry makes the slot read as normal site state rather than one conspicuous gap.
- Copy: "We're preparing case studies from our current Pacific telecom engagements for publication as each partner goes live." Reads as deliberate editorial posture, not a redacted document.

### Risk 3: Build script change breaks existing deploy
**Impact:** High — the live homepage goes down if `npm run build` fails.
**Mitigation:**
- Make the `copy:html` change additive: keep the existing `cp -r src/*.html dist/` for top-level files, add explicit copies for the nested practices directory.
- Verify locally with `npm run clean && npm run build` before pushing.
- If the deploy workflow fails, revert is a single commit — homepage stays up from the last successful deploy.

### Risk 4: Content drifts from truth as capabilities change
**Impact:** Low-medium. A practice page from 2026 that still talks about 2026 engagement patterns in 2027 looks stale or misleading.
**Mitigation:** Accept this — a date-aware refresh is a future concern. Keep copy concrete and in-present-tense; when it ages out, update it. Don't try to future-proof every sentence.

### Risk 5: Placeholder coordination with #7 produces a duplicate component
**Impact:** Low. Both pages end up with a "case study placeholder" block that looks different, creating visual inconsistency.
**Mitigation:** Resolve the placeholder-home question (Open Question 1) before both plans hit build. If the shared case-study component lives on #7's surface only, this page links to it; if it lives here only, #7 links here; if it's on both, both plans use the same HTML snippet.

## Race Conditions

No race conditions — static HTML, synchronous build, single-threaded reader experience.

## No-Gos (Out of Scope)

- **Writing the named case study for the current client.** Blocked by confidentiality until client launches. Future follow-up issue.
- **Building a second practice page.** Sector or region expansion (e.g., "Pacific fintech," "Southeast Asia telecom") is out of scope. One page this round.
- **Adding analytics, tracking pixels, or A/B testing infrastructure.** Not in scope.
- **CMS or templating system for future practice pages.** Premature — revisit when a second practice page is a real requirement.
- **Navigation redesign.** #6 owns homepage/nav changes. This plan adds the minimum link and defers IA.
- **Changing the site's visual design system.** Inherit the homepage aesthetic. Design-system changes are a separate concern.

## Update System

No update system changes required — this feature is a public static website change deployed via GitHub Actions to GitHub Pages. Not part of the Valor bridge infrastructure.

## Agent Integration

No agent integration required — this is a marketing-site change, not a bridge/agent capability.

## Documentation

### Feature Documentation
- [ ] No `docs/features/` entry required — this repo is a small static site, not the Valor bridge. The plan document itself is the durable record.

### External Documentation Site
- [ ] Not applicable.

### Inline Documentation
- [ ] Add a brief HTML comment at the top of the practice page noting its purpose and the confidentiality constraint so future editors don't accidentally add client-identifying content.

## Success Criteria

- [ ] Page exists at `/practices/telecom` (or agreed URL) and is served via GitHub Pages.
- [ ] `npm run build` emits the page to `dist/practices/telecom/index.html` with styles applied.
- [ ] Homepage links to the new page.
- [ ] Page copy describes Yudame's Pacific telecom practice area honestly — only claims Yudame can stand behind today.
- [ ] Page includes a structurally-complete case-study placeholder slot that reads naturally, with no client-identifying hints.
- [ ] **Confidentiality gate (HARD ACCEPTANCE BLOCKER):**
  - [ ] Human reviewer has read the final page copy end-to-end against the confidentiality checklist and signed off.
  - [ ] Human reviewer has read the PR diff, PR title/body, and every commit message in the feature branch and confirmed no client-identifying strings appear.
  - [ ] No logo, screenshot, or brand asset anywhere in the change.
  - [ ] No country-level specificity narrow enough to single the client out.
  - [ ] No metrics, subscriber counts, launch dates, or product names that uniquely identify the client.
  - [ ] No plan-doc, issue-comment, or commit-message leak.
- [ ] Visual aesthetic consistent with homepage (brand colors, font, spacing).
- [ ] Renders cleanly on desktop and mobile in `npm run dev`.
- [ ] GitHub Pages deploy workflow publishes the page at the expected URL post-merge.

## Team Orchestration

### Team Members

- **Builder (practice-page)**
  - Name: `telecom-page-builder`
  - Role: Implement the practice page HTML, update `package.json` build scripts, add homepage link.
  - Agent Type: builder
  - Resume: true

- **Validator (practice-page)**
  - Name: `telecom-page-validator`
  - Role: Verify build output, URL renders, visual consistency.
  - Agent Type: validator
  - Resume: true

- **Confidentiality Reviewer (human)**
  - Name: `tom` (human)
  - Role: Read final copy and full PR surface (diff, title, body, commits) against the confidentiality checklist. **Blocking gate — no agent bypass.**
  - Agent Type: human
  - Resume: n/a

## Step by Step Tasks

### 1. Confirm URL convention and placeholder home
- **Task ID**: decide-url-and-placeholder-home
- **Depends On**: none
- **Assigned To**: Tom (via Open Questions answers)
- **Agent Type**: human
- **Parallel**: false
- Resolve Open Question 1 (placeholder home — here, #7, or both).
- Resolve Open Question 2 (URL shape — `/practices/telecom/` vs `/pacific-telecom/`).
- Coordinate with the #7 planner (who is making the symmetric call in parallel).

### 2. Build the practice page
- **Task ID**: build-practice-page
- **Depends On**: decide-url-and-placeholder-home
- **Validates**: Visual inspection at `http://localhost:8080/practices/telecom/` after `npm run dev`; `dist/practices/telecom/index.html` exists after `npm run build`.
- **Informed By**: Issue #5 vocabulary if available at build time; Open Question answers.
- **Assigned To**: telecom-page-builder
- **Agent Type**: builder
- **Parallel**: false
- Create `src/practices/telecom/index.html` (or agreed path) with head/font/Tailwind setup copied from `src/index.html`.
- Write practice statement, capability framing, and Pacific-region section. Use only capabilities Yudame can stand behind today.
- Add case-study placeholder block with natural "forthcoming" framing.
- Add HTML comment at top noting confidentiality constraint.
- Update `package.json` `copy:html` to emit nested practice page to `dist/practices/telecom/index.html` without breaking existing top-level copy.
- Add link from `src/index.html` to `/practices/telecom/` at the placement agreed in #6 coordination (or a sensible minimum footer/body link if #6 not yet landed).
- Run `npm run clean && npm run build` locally and verify `dist/practices/telecom/index.html` exists and renders.

### 3. Validate build and visual output
- **Task ID**: validate-practice-page
- **Depends On**: build-practice-page
- **Assigned To**: telecom-page-validator
- **Agent Type**: validator
- **Parallel**: false
- Run `npm run clean && npm run build` and confirm exit 0.
- Confirm `dist/practices/telecom/index.html` exists and is styled (contains Tailwind-compiled classes, has brand colors).
- Run `npm run dev` and screenshot the page at desktop (1440px) and mobile (375px) breakpoints.
- Confirm homepage link renders and resolves to the page locally.
- Scan the page copy for any of: country names (Fiji/Samoa/Tonga/Vanuatu/Solomon Islands/PNG/etc.), subscriber counts, product names, client-specific language. Report any hits as a BLOCKER.

### 4. Confidentiality review (HARD GATE)
- **Task ID**: review-confidentiality
- **Depends On**: validate-practice-page
- **Assigned To**: Tom (human)
- **Agent Type**: human
- **Parallel**: false
- Read the final page copy end-to-end.
- Read the PR diff, PR title, PR body, and every commit message in the feature branch.
- Confirm zero client-identifying content in any surface.
- Sign off in the PR. If sign-off is withheld, the PR does not merge regardless of other validation results.

### 5. Merge and deploy
- **Task ID**: deploy-practice-page
- **Depends On**: review-confidentiality
- **Assigned To**: Tom (human)
- **Agent Type**: human
- **Parallel**: false
- Merge PR to `main`.
- Monitor GitHub Actions deploy workflow until the new URL is live.
- Smoke-check the live URL: page loads, styled, homepage link resolves, no client-identifying content visible.

## Verification

| Check | Command | Expected |
|-------|---------|----------|
| Build succeeds | `npm run clean && npm run build` | exit code 0 |
| Page emitted | `test -f dist/practices/telecom/index.html` | exit code 0 |
| Homepage link present | `grep -n '/practices/telecom' dist/index.html` | output contains `/practices/telecom` |
| No forbidden country names in page | `grep -Eic 'Fiji\|Samoa\|Tonga\|Vanuatu\|Solomon\|Papua' dist/practices/telecom/index.html` | output `0` |
| No forbidden country names in commit messages | `git log --format=%B origin/main..HEAD \| grep -Eic 'Fiji\|Samoa\|Tonga\|Vanuatu\|Solomon\|Papua'` | output `0` |
| Page is styled (Tailwind compiled) | `grep -c 'yudame-' dist/practices/telecom/index.html` | output > 0 |

Note: the forbidden-country check is a **minimum** guard, not a substitute for the human confidentiality review. A client can be identified without any country name appearing (e.g., by product specifics or brand-adjacent phrasing), which is why the human gate is non-negotiable.

## Critique Results

<!-- Populated by /do-plan-critique (war room). Leave empty until critique is run. -->

---

## Open Questions

1. **Placeholder home — where does the case-study slot live?** Three options, all viable; the sibling-issue #7 planner is making the same call in parallel:
   - **(a)** Placeholder lives only on this practice page (`/practices/telecom/`). Case-studies surface (#7) links here for the Pacific telecom entry.
   - **(b)** Placeholder lives only on the case-studies surface (#7). This practice page links there for the Pacific telecom case study.
   - **(c)** Both surfaces carry a placeholder block using the same HTML snippet. This page anchors the practice-area context; #7 anchors the case-study registry.
   - Recommendation: **(c)** — duplication is cheap in static HTML, and symmetric placeholders read less suspicious than a single conspicuous slot. But the #7 planner's decision should drive this — coordinate before both plans hit build.

2. **URL shape.** Options:
   - `/practices/telecom/` (directory-based, scales to siblings like `/practices/fintech/`)
   - `/pacific-telecom/` (flat, region-sector compound)
   - `/practices/pacific-telecom/` (both)
   - Recommendation: `/practices/telecom/` — scales cleanly, region context is set by page content rather than URL. But #7 and #8 are independently choosing URL shapes right now; coordinate.

3. **Homepage link placement.** #6 owns homepage IA. Three options pending #6's resolution:
   - **(a)** Inline link in homepage body copy ("Our Pacific telecom practice…").
   - **(b)** Top-nav entry ("Practices → Telecom").
   - **(c)** Footer-only link.
   - Recommendation: **(a) or (b)** per #6's decision. Avoid footer-only — the point is to surface the credential, not bury it.

4. **Is it acceptable to ship this before #5 (positioning brief) lands?** #5 produces vocabulary the copy should use. Options:
   - **(a)** Wait for #5 — delay this plan's build until #5's output is available.
   - **(b)** Ship with conservative self-authored copy now; refine after #5 lands.
   - Recommendation: **(a)** if #5 is landing within a few days; **(b)** if #5 is weeks away. Cost of re-editing copy once is low.

5. **How strict is the country-level specificity ban?** The plan forbids country naming that would single the client out. Clarify: is the ban absolute (no country names in copy at all), or scoped to specific countries where Yudame only has one engagement? The absolute ban is safer; the scoped ban allows richer copy. Tom to decide.

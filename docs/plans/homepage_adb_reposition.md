---
status: Planning
type: feature
appetite: Small
owner: Valor
created: 2026-04-23
tracking: https://github.com/yudame/yuda.me/issues/6
last_comment_id:
---

# Homepage ADB / DMC / Pacific Reposition

## Problem

**Current behavior:**
`src/index.html` leads with "Building exceptional products" and three capability cards — AI Integration, Product Architecture, Rapid Prototyping. The philosophy section talks about "forward-thinking companies," "AI-forward approach," and "unprecedented quality at extraordinary speed." Nothing on the page tells a development-sector evaluator (ADB task manager, DMC government digital team, Pacific telecom buyer) that Yudame is:

- US-incorporated but HQ'd in Thailand — a DMC
- Practiced at full IP transfer / source-code handover
- Experienced delivering in the Pacific region

Today the homepage reads as generic US-dev-shop copy. There is no differentiation for ADB-adjacent buyers who speak a specific vocabulary (capacity building, knowledge transfer, DMC, procurement, compliance).

**Desired outcome:**
A copy-only reposition of `src/index.html` that surfaces the three Yudame credentials (Thailand DMC HQ, IP transfer as core practice, Pacific-region client experience) and adopts ADB vocabulary authentically — without any aesthetic regression. The current layout (Hero → Philosophy → Capabilities → Work Links → Team → Footer) absorbs the change. A development-sector evaluator scanning `yuda.me` for 30 seconds should leave with a concrete mental model of what Yudame is and where it works.

## Freshness Check

**Baseline commit:** `9bd7765` (Revert "Migrate domain from yuda.me to yudame.org")
**Issue filed at:** 2026-04-23T10:11:46Z
**Disposition:** Unchanged — filed today, no drift.

**File:line references re-verified:**
- `src/index.html:568-572` — Hero h1 "Building exceptional products" — still present, matches issue claim.
- `src/index.html:581-594` — Philosophy block with "forward-thinking companies" / "AI-forward approach" — still present.
- `src/index.html:603-624` — Three capability cards (AI Integration, Product Architecture, Rapid Prototyping) — still present.
- `src/index.html:763-772` — Footer is minimal (copyright only, no page links) — still the case.

**Cited sibling issues re-checked:**
- #5 (ADB 2026 positioning brief) — OPEN, being planned in parallel. The brief itself does not yet exist.
- #7 (Case studies surface) — OPEN.
- #8 (Security & compliance page) — OPEN.
- #9 (Pacific telecom practice page) — OPEN.

**Commits on main since issue was filed (touching referenced files):** None. Issue was filed today at 10:11Z; baseline commit `9bd7765` pre-dates the issue.

**Active plans in `docs/plans/` overlapping this area:** Four sibling plans (issues #5, #7, #8, #9) are being authored in the same batch. Plan #5 produces the vocabulary cheat-sheet this plan consumes; plans #7/#8/#9 add future surfaces the footer may eventually link to. No direct file overlap.

**Notes:** Freshness is trivially clean because issue was filed today. The only coordination concern is cross-issue dependency on #5.

## Prior Art

- **No prior issues found related to this work.** This is the first repositioning pass against the ADB/development-sector audience for the marketing site.
- **Related commit `1cc0e68`**: QuickBooks page removed in favor of single-page collapse — confirms the aesthetic direction is "minimal single page," which this plan preserves.
- **Commit `3ef612e`**: Added "AI Tools" and "Research" links below capability cards — the existing `work-links` pattern is the established way to add a small new inline block without restructuring the page. Useful reference for the Thailand/Pacific credentials block if that's where it lands.

## Research

Research is purely internal (codebase + sibling issues) and dependent on issue #5's output. WebSearch was not executed because the vocabulary source of truth is the pending ADB 2026 positioning brief; running our own WebSearch here would duplicate #5 and risk drift between the two.

**Planned vocabulary inputs (from issue #5 output):**
- ADB task-manager-facing terms: capacity building, knowledge transfer, Developing Member Country (DMC), digital public goods, financial inclusion, beneficiary, implementing partner, procurement-ready.
- IP transfer framing: source-code handover, no vendor lock-in, client-owned artifacts, post-engagement operability.
- Regional framing: Pacific region, South-East Asia, ADB member countries.

No relevant external findings at plan time — the plan can be written against the intended shape of #5's output; the build must wait for #5 to actually ship the brief before copy is finalized.

## Data Flow

Not applicable — this is a static HTML copy change. No runtime data flow.

## Architectural Impact

- **New dependencies**: None. No JS, no CSS framework, no external services.
- **Interface changes**: None.
- **Coupling**: Unchanged. This issue tightens coupling between `src/index.html` and the yet-to-exist `docs/research/adb-2026-positioning.md` (from issue #5) during the build phase only — the brief is a source of vocabulary, not a runtime dependency.
- **Data ownership**: Unchanged.
- **Reversibility**: Fully reversible — a single-file copy change, trivial to revert via `git revert`.

## Appetite

**Size:** Small

**Team:** Solo dev (builder), one reviewer (Tom for brand voice + client-confidentiality sign-off).

**Interactions:**
- PM check-ins: 1 (after draft copy, before merge — brand voice + client confidentiality review)
- Review rounds: 1

This is a copy-only change on a 775-line single-page site. The work itself is ~30 minutes of writing and HTML edits. The cost is alignment: making sure the voice doesn't break and no client gets named.

## Prerequisites

| Requirement | Check Command | Purpose |
|-------------|---------------|---------|
| Issue #5 brief exists | `test -f docs/research/adb-2026-positioning.md` | Vocabulary source of truth for ADB-flavored copy — build must not start without it |
| Node + npm installed | `node --version && npm --version` | Required for `npm run dev` preview |
| Pencil MCP available (only if `.pen` mirror is in scope) | Call `mcp__pencil__get_editor_state` and confirm no error | Design-file edits must use Pencil MCP tools |

Plan-time prerequisites: none — the plan can be written now. The brief is a **build-time** prerequisite.

## Solution

### Key Elements

- **Hero (no aesthetic change)**: Keep h1 "Building exceptional products." Optional `<meta name="description">` refresh to mention DMC/Pacific context (invisible to viewers, but surfaced to LinkedIn/Google previews where development-sector buyers scan).
- **Philosophy rewrite**: Replace the three `<p>` blocks with copy that naturally uses 3–5 ADB-vocabulary terms and introduces the Thailand HQ + DMC status. Same number of paragraphs, same visual weight, same `.highlight` span pattern.
- **Capability cards rewrite**: Keep three-card grid. Rewrite one card around IP transfer / knowledge handover explicitly. Rewrite the other two so the set collectively reads as a development-partner capabilities surface, not a pure tech-stack framing. Card titles stay short (one to three words) to preserve rhythm.
- **Thailand/Pacific credentials placement (open)**: Three candidate placements — see Open Questions. Preferred default is a single additional `<p>` at the end of the philosophy block, because it costs zero layout change.
- **Footer**: Out of scope for this issue — placeholder links to #7/#8/#9 are deferred until those surfaces actually exist.
- **Design file (`docs/designs/homepage.pen`)**: Mirror the copy changes only if Tom confirms the `.pen` file drives any published output. If yes, edits go through Pencil MCP tools exclusively (`batch_get` / `batch_design`) — never via Read/Edit/Write.

### Flow

Evaluator arrives at `yuda.me` → Reads hero ("Building exceptional products") → Scrolls to philosophy (now surfaces DMC/Thailand + ADB vocabulary) → Scans three capability cards (one now explicitly says IP transfer) → Sees team → Leaves with: "US firm, Thailand DMC HQ, Pacific experience, hands over IP."

### Technical Approach

- Single-file edit: `src/index.html`.
- Keep the existing `.highlight` span pattern for emphasis — no new CSS classes.
- Absolutely no new colors, fonts, hero layout, or component types. Tailwind utility set unchanged.
- If a new `.credentials` or `where-we-work` block is chosen (Open Question 1), it MUST reuse existing spacing rhythm and typography — no bespoke styling.
- Copy draft MUST be reviewed against a client-confidentiality checklist before merging (see Risks section).
- Design-file mirror (`docs/designs/homepage.pen`) is OPTIONAL and depends on Tom's call on whether the `.pen` file is authoritative.

## Failure Path Test Strategy

### Exception Handling Coverage
No exception handlers in scope — this is a static HTML copy change.

### Empty/Invalid Input Handling
No function inputs. `<script>new Date().getFullYear()</script>` in the footer is untouched.

### Error State Rendering
No error states. Visual QA via `npm run dev` on desktop + mobile viewports is the acceptance check.

## Test Impact

No existing tests affected — this is a static HTML copy change to a marketing site with no test suite. Visual QA is performed manually via `npm run dev`.

## Rabbit Holes

- **Rewriting the hero**. Tempting to lead with "Thailand-based digital partner for ADB DMC work." Do not do it. The hero is minimal by design; crowding it breaks the aesthetic and weakens the site.
- **Adding a new "About" block for company history**. Out of scope. If DMC framing needs more than 1–2 lines, that is a separate page (likely alongside #9), not homepage copy.
- **Repainting Tailwind config / brand colors**. Completely out of scope. The issue explicitly forbids aesthetic rework.
- **Editing `.pen` files with Read/Edit/Write**. Blocked by project rules. Pencil MCP only. If Pencil MCP is unavailable, defer the `.pen` mirror rather than bypassing.
- **Finalizing copy before issue #5 ships**. Do not draft the final copy against guessed vocabulary. Draft against placeholders; swap in real terms once the brief exists.
- **Writing the vocabulary brief ourselves**. That is issue #5's job. Do not inline the research here.

## Risks

### Risk 1: Client Confidentiality Leak (Pacific Telecom)
**Impact:** Yudame is mid-delivery for a Pacific telecom operator that **cannot be publicly named or uniquely identified**. Homepage copy, issue comments, and plan documents must not name the client or reveal uniquely-identifying details (country-specific telecom regulator names, exact country if only one operator exists there, named projects, identifiable metrics). A leak would breach confidentiality and damage trust.
**Mitigation:**
- Plan, build, and review all constrain themselves to generic "Pacific region client experience" framing.
- Pre-merge checklist includes an explicit client-confidentiality line item. Tom signs off.
- Forbidden: named country where there is only one major telecom operator; named operator; named regulator; named minister; named project.
- Allowed: "Pacific region," "Pacific telecom operator," "Pacific-region client," plural framings ("we have delivered across the Pacific").

### Risk 2: Vocabulary Inauthenticity
**Impact:** Sprinkling ADB terms without fluency reads as cargo-culting and damages credibility with the exact audience the page is targeting.
**Mitigation:** Use only the vocabulary cheat-sheet from issue #5 (when it ships). Prefer 3–5 authentic terms over 10 forced ones. Acceptance criterion is "at least 5" — treat this as a floor, not a target.

### Risk 3: Aesthetic Regression
**Impact:** Adding new copy blocks or cards disrupts the intentional minimalism. The site currently reads as confident and modern; a repositioning pass can accidentally make it feel busy, corporate, or hedged.
**Mitigation:** Preferred placement is in-place rewrites (philosophy rewrite, one-card rewrite). New blocks are opt-in and must match existing rhythm. `npm run dev` visual diff desktop + mobile before merge.

### Risk 4: Issue #5 Dependency Slippage
**Impact:** If #5 is delayed, this plan is blocked at build time. Plan-time work can still complete.
**Mitigation:** Plan phase (this document) proceeds immediately. Build phase gates on `docs/research/adb-2026-positioning.md` existing. If #5 is delayed, build can use a lightweight working vocabulary list extracted from ADB public docs, but only if Tom explicitly approves.

### Risk 5: `.pen` File Divergence
**Impact:** If `docs/designs/homepage.pen` is updated with Read/Edit/Write, file becomes corrupt (contents are encrypted and only Pencil MCP can read/write them).
**Mitigation:** Hard rule — `.pen` files are Pencil MCP only. Builder spike-1 confirms the edit flow before attempting any `.pen` write. If MCP unavailable at build time, defer the `.pen` mirror entirely.

## Race Conditions

No race conditions identified — all operations are synchronous static-file edits on a single-author branch.

## No-Gos (Out of Scope)

- **New pages** (`/security`, `/case-studies`, `/pacific`, etc.) — covered by sibling issues #7, #8, #9.
- **Hero layout or aesthetic changes** — explicit issue constraint.
- **New color accents, new fonts, new hero imagery** — explicit issue constraint.
- **Footer page-link additions** — deferred until #7/#8/#9 ship.
- **Tailwind config changes** — out of scope.
- **Case-study content** — out of scope (belongs to #7).
- **Writing the ADB vocabulary cheat-sheet** — belongs to #5, not this issue.
- **Naming the Pacific telecom client** — strictly forbidden by client confidentiality.
- **Translations / i18n** — not in scope.

## Update System

No update-system changes — this is a static marketing page. The change ships via the standard `main` → GitHub Actions → GitHub Pages pipeline. No new dependencies to propagate.

## Agent Integration

No agent integration required — this is a marketing site copy change, not an agent-facing feature.

## Documentation

### Feature Documentation
- No `docs/features/` entry needed — this is a marketing copy change, not a product feature.

### External Documentation Site
- None.

### Inline Documentation
- If the build adds a new copy block (e.g., a `credentials` section), add an HTML comment labeling it: `<!-- DMC / Pacific credentials block — updated per issue #6 -->`.

## Success Criteria

- [ ] Homepage copy uses at least 5 terms drawn from the ADB 2026 vocabulary cheat-sheet (source: `docs/research/adb-2026-positioning.md` from #5)
- [ ] Thailand HQ + "US-incorporated, HQ'd in ADB DMC" framing is visible on the homepage without clicking (above the footer)
- [ ] IP transfer / source-code handover is stated explicitly as a Yudame practice (not merely implied by "partnership")
- [ ] At least one capability card or philosophy line signals development-sector work (capacity building, knowledge transfer, financial inclusion, or similar) authentically
- [ ] Visual aesthetic preserved: no new color accents, no new font, no new hero layout (git diff in `src/index.html` is copy-only, no new CSS classes, no new `<style>` additions)
- [ ] `npm run dev` renders cleanly on desktop (>=1200px) and mobile (375px) viewports
- [ ] Client confidentiality: no direct or uniquely-identifying mention of the Pacific telecom client (Tom signs off on this specifically)
- [ ] If `docs/designs/homepage.pen` is updated, all edits use Pencil MCP tools (`batch_get` / `batch_design` only — no Read/Edit/Write)
- [ ] Issue #5 brief exists at `docs/research/adb-2026-positioning.md` before build starts

## Team Orchestration

### Team Members

- **Builder (homepage-copy)**
  - Name: homepage-copy-builder
  - Role: Rewrite `src/index.html` philosophy + one capability card; add optional Thailand/Pacific credentials block per chosen placement.
  - Agent Type: builder
  - Resume: true

- **Builder (design-mirror)** — conditional
  - Name: design-mirror-builder
  - Role: If Tom approves and `.pen` is in scope, mirror copy edits into `docs/designs/homepage.pen` via Pencil MCP.
  - Agent Type: designer
  - Resume: true

- **Validator (visual-qa)**
  - Name: homepage-visual-validator
  - Role: Run `npm run dev`, screenshot desktop + mobile, verify no aesthetic regression and all acceptance criteria met.
  - Agent Type: validator
  - Resume: true

## Step by Step Tasks

### 1. spike-1: Confirm Pencil MCP edit flow for `.pen` mirror
- **Task ID**: spike-pencil-flow
- **Depends On**: none
- **Assumption**: "`mcp__pencil__batch_get` + `mcp__pencil__batch_design` can round-trip a text-node edit on `docs/designs/homepage.pen` without corrupting the file."
- **Method**: code-read + tiny prototype (read one text node, no write)
- **Agent Type**: builder
- **Time cap**: 5 minutes
- **Parallel**: true
- Confirm MCP server reachable.
- `batch_get` against `docs/designs/homepage.pen` to find the philosophy text node.
- Do NOT commit any changes. Report: can we edit `.pen` safely, yes/no.

### 2. Draft new copy against vocabulary brief
- **Task ID**: build-copy-draft
- **Depends On**: Issue #5 merged (external, build-time prerequisite)
- **Validates**: Copy draft reviewed by Tom; acceptance criteria 1–4 in Success Criteria
- **Informed By**: spike-pencil-flow (decides whether `.pen` mirror is in scope)
- **Assigned To**: homepage-copy-builder
- **Agent Type**: builder
- **Parallel**: false
- Read `docs/research/adb-2026-positioning.md` (from #5). Extract the vocabulary cheat-sheet.
- Draft new philosophy paragraphs (3 paragraphs, same shape as current).
- Draft one rewritten capability card around IP transfer / source-code handover.
- Draft the Thailand/Pacific credentials line(s) per the chosen placement from Open Question 1.
- Confirm zero named/uniquely-identifying references to the Pacific telecom client (self-check before handoff).
- Hand draft to Tom for brand-voice + confidentiality sign-off before writing HTML.

### 3. Apply copy to `src/index.html`
- **Task ID**: build-html-edit
- **Depends On**: build-copy-draft (with Tom sign-off)
- **Validates**: Acceptance criteria 5 (aesthetic preserved) — git diff is copy-only, no CSS changes
- **Assigned To**: homepage-copy-builder
- **Agent Type**: builder
- **Parallel**: false
- Edit `src/index.html` philosophy section (approx lines 578–597 against baseline `9bd7765`).
- Edit one capability card (approx lines 603–624 against baseline).
- Apply chosen Thailand/Pacific placement per Open Question 1.
- Verify no new CSS classes, no new `<style>` additions, no new colors/fonts. Pure copy swap.
- Add inline comment labeling any new copy block with `<!-- issue #6 -->`.

### 4. Mirror to `homepage.pen` (conditional)
- **Task ID**: build-pen-mirror
- **Depends On**: build-html-edit, spike-pencil-flow (yes)
- **Assigned To**: design-mirror-builder
- **Agent Type**: designer
- **Parallel**: false
- Only if spike-1 confirmed safe Pencil MCP flow AND Tom confirmed `.pen` is authoritative.
- Use `mcp__pencil__batch_get` to locate text nodes.
- Use `mcp__pencil__batch_design` to apply updates.
- Absolutely no Read/Edit/Write on `.pen` files.
- If either prerequisite fails, skip this task and note in the PR description.

### 5. Visual QA
- **Task ID**: validate-visual
- **Depends On**: build-html-edit
- **Assigned To**: homepage-visual-validator
- **Agent Type**: validator
- **Parallel**: false
- Run `npm install && npm run dev`.
- Load `http://localhost:8080` in a browser.
- Screenshot desktop (1440px) + mobile (375px).
- Verify no layout regression vs. current site.
- Confirm all seven non-conditional Success Criteria checkboxes pass.

### 6. Final Validation
- **Task ID**: validate-all
- **Depends On**: validate-visual, build-pen-mirror (if ran)
- **Assigned To**: homepage-visual-validator
- **Agent Type**: validator
- **Parallel**: false
- Run through full Success Criteria checklist.
- Explicit confidentiality double-check against PR body + final `src/index.html` copy.
- Generate final report with screenshots.

## Verification

| Check | Command | Expected |
|-------|---------|----------|
| Brief exists (build-time gate) | `test -f docs/research/adb-2026-positioning.md && echo OK` | output contains OK |
| HTML still valid | `node -e "const f=require('fs').readFileSync('src/index.html','utf8'); if(!f.includes('</html>'))process.exit(1)"` | exit code 0 |
| No new CSS classes introduced | `git diff main -- src/index.html \| grep -cE '^\+\s*\.[a-z][a-z0-9_-]*\s*\{' \|\| true` | output == 0 |
| No client name leak | `grep -ciE '(REDACTED_CLIENT_NAMES_LIST)' src/index.html` | output == 0 |
| Dev server boots | `npm run dev &` then `curl -s http://localhost:8080/` | output contains `</html>` |
| At least 5 ADB-vocabulary terms | `grep -ciE '(DMC\|capacity building\|knowledge transfer\|financial inclusion\|digital public goods\|beneficiary\|implementing partner\|Pacific\|Thailand\|source-code handover\|IP transfer)' src/index.html` | output > 4 |

Note: the client-name leak grep list is populated in the PR description by Tom at build time — not committed to the plan to avoid leaking the list itself.

## Critique Results

<!-- Populated by /do-plan-critique. Empty until critique runs. -->

---

## Open Questions

1. **Placement of Thailand/Pacific credentials block.** Three candidates:
   (a) Append one `<p>` at the end of the philosophy section (lowest-cost, preserves minimalism).
   (b) Replace hero sub-copy (no current sub-copy exists — would require adding one, which risks crowding the hero).
   (c) New small "where we work" strip between capabilities and team (a fresh block; closest to a mini-section).
   Preferred default: **(a)**. Needs Tom's sign-off before build.

2. **Is `docs/designs/homepage.pen` authoritative?** If yes, `.pen` mirror is required and spike-1 gates the build. If no (design file is reference-only), skip `.pen` mirror entirely. Needs Tom's call.

3. **Capability-card rewrite — rewrite all three, or swap one?** Two options:
   (a) Rewrite one (IP transfer / knowledge handover), leave two ("AI Integration" + "Product Architecture" or "Rapid Prototyping") largely intact. Minimal change, but the three-card set reads as a mismatched pair.
   (b) Rewrite all three to read coherently as development-partner capabilities. More work, stronger story. Risk: loses "AI-forward" cue that other audiences (startups, tech buyers) respond to.
   Lean: **(b)**, with one card preserving a light AI-capability framing. Needs Tom's call.

4. **Meta description refresh.** The current `<meta name="description">` (line 9) is not viewer-visible but shows in LinkedIn/Google previews. Should it be rewritten to include DMC/Pacific framing? (Default: yes, light rewrite — but flagging since it wasn't explicit in the issue acceptance criteria.)

5. **Fallback if issue #5 slips.** If the ADB brief is delayed more than a week past plan-to-build handoff, do we (a) wait for #5, or (b) produce a lightweight in-line vocabulary list extracted from ADB public docs as a stopgap? Lean: **(a) wait** — forced copy without a real brief risks inauthenticity.

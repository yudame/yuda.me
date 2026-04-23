---
status: Planning
type: chore
appetite: Small
owner: valor
created: 2026-04-23
tracking: https://github.com/valorengels/yuda.me/issues/5
last_comment_id:
---

# ADB 2026 Positioning Brief

## Problem

Yudame wants to be staffed onto ADB-funded digital projects, but the current yuda.me homepage speaks in generic "AI-forward product partner" language. ADB task managers scanning vendor profiles look for vocabulary that echoes their own 2026 priorities — digital public infrastructure, inclusive digital transformation, Pacific digital financial inclusion, AI-enabled public services. Writing four downstream site rewrites (homepage, case studies, security & compliance, Pacific practice page) without first grounding in ADB's actual 2026 vocabulary will produce four pieces of generic copy that miss the mark in four different directions.

**Current behavior:** `src/index.html` uses generic positioning ("AI Integration", "Product Architecture", "Rapid Prototyping"). No internal reference doc captures ADB's 2026 digital themes or vocabulary. Downstream issues #6, #7, #8, #9 cannot start without this foundation.

**Desired outcome:** A single internal brief at `docs/research/adb-2026-positioning.md` that captures (a) 3–5 ADB 2026 digital priority themes with source URLs, (b) a 10–20 term vocabulary cheat-sheet with brief annotations on what each signals, and (c) a Yudame-to-ADB angle map that honestly threads existing Yudame work (AI-forward dev, IP transfer, Thailand HQ, Pacific telecom engagement) into each theme. This brief becomes the vocabulary source of truth for issues #6, #7, #8, #9.

## Freshness Check

**Baseline commit:** `9bd7765`
**Issue filed at:** 2026-04-23T10:11:41Z (today)
**Disposition:** Unchanged — issue filed today, no commits on main since. No file:line references to re-verify. No drift possible.

**Notes:** Per the planner's note, Phase 0.5 is trivial for this issue. No siblings #6/#7/#8/#9 have landed yet; they are explicitly downstream consumers of this brief.

## Prior Art

No prior issues or PRs in this repo have attempted ADB positioning research. `docs/research/` does not yet exist. `src/index.html` contains no ADB, DMC, Pacific, or telecom vocabulary (grep confirmed in issue recon). Greenfield deliverable.

## Research

External research gathered during Phase 0.7 to seed — but not replace — the actual research work scoped by this plan. The builder executing this plan will go deeper; these findings confirm that the needed sources exist and are accessible.

**Queries used:**
- `ADB Asian Development Bank Digital Sector Group 2026 priorities`
- `ADB Strategy 2030 digital transformation 2026 supplement`
- `ADB Pacific Department digital financial inclusion 2026 projects`

**Key findings:**

1. **ADB has canonized "digital transformation" as one of five strategic focus areas** (alongside climate, private sector, regional cooperation, resilience) per the Work Program and Budget Framework 2026–2028. This framing — "five focus areas" with digital as a peer — is vocabulary the brief should preserve verbatim.
   Source: [Work Program and Budget Framework, 2026-2028](https://www.adb.org/documents/work-program-and-budget-framework-2026-2028)

2. **"Digital public infrastructure" (DPI) is ADB's dominant current-year phrase** for the investment category covering digital ID, payment rails, and data exchange layers. The Fiji national digital ID work and the Pacific finance-sector DPI initiatives use this language directly. The brief must capture DPI as a top-shelf term.
   Sources: [ADB Supports Digitalization and Financial Inclusion in Fiji](https://www.adb.org/news/adb-supports-digitalization-and-financial-inclusion-fiji), [Supporting Inclusive and Sustainable Finance in the Pacific (57169-001)](https://www.adb.org/projects/57169-001/main)

3. **The Strategy 2030 Digital Technology Directional Guide is the canonical ADB digital-framing document** — a vendor brief that doesn't cite this will read as uninformed. The guide frames digital work as "supporting inclusive digital transformation for Asia and the Pacific."
   Source: [Strategy 2030 Digital Technology Directional Guide](https://www.adb.org/documents/strategy-2030-digital-technology-directional-guide)

4. **ADB's 2025 flagship policy report is titled "Harnessing Digital Transformation for Good"** — the phrasing "for good" and "harnessing" are deliberate ADB register and worth preserving in the vocabulary sheet.
   Source: [Asian Development Policy Report 2025](https://www.adb.org/sites/default/files/publication/1050686/asian-development-policy-report-2025.pdf)

5. **Pacific-specific angle:** ADB explicitly frames Pacific financial exclusion (>30% of adults in PNG, Samoa, Solomon Islands, Vanuatu) as solvable through DPI + digital financial services. This is the exact wedge for a Yudame Pacific practice page.
   Sources: [Digital Financial Services in the Pacific](https://www.adb.org/publications/digital-financial-services-pacific), [ADB in the Pacific](https://www.adb.org/where-we-work/pacific)

6. **AI vocabulary caveat:** ADB's current digital publications lean on "AI-enabled public services" rather than "AI-first" or "AI-native." Yudame's "AI-forward" phrasing is adjacent but not identical; the brief should flag this as a register adjustment to consider for downstream copy.
   Sources: [ADB's Work on Digital Technology](https://www.adb.org/what-we-do/topics/digital-technology/overview)

**How findings inform the plan:** They confirm (a) authoritative sources exist and are web-accessible (no paywalls blocking the builder), (b) the vocabulary cheat-sheet will have ample material (DPI, inclusive digital transformation, harnessing, AI-enabled public services, digital financial services, etc.), and (c) the Yudame-to-ADB angle map has natural threading points — Pacific telecom engagement maps to Pacific DPI/DFS themes, AI-forward dev maps to AI-enabled public services (with register adjustment), Thailand HQ maps to DMC-resident vendor credibility.

## Appetite

**Size:** Small

**Team:** Solo dev (single builder producing one markdown document)

**Interactions:**
- PM check-ins: 0 (scope is crisp — the issue lists the sections required)
- Review rounds: 1 (user reviews the brief before downstream issues #6–#9 consume it)

Small fits because: single markdown deliverable, sources identified in Phase 0.7, no code changes, no spikes needed, acceptance criteria measurable by inspection.

## Prerequisites

No prerequisites — this work has no external dependencies. All sources are publicly accessible via the web.

## Solution

### Key Elements

- **`docs/research/` directory**: New top-level research directory under `docs/`. First entry; set the convention.
- **`docs/research/adb-2026-positioning.md`**: The brief itself. Four sections: ADB 2026 digital priorities, vocabulary cheat-sheet, Yudame-to-ADB angle map, source links.
- **Internal-facing tone**: This is a reference document, not marketing copy. Terse, cited, skimmable. No hedging; if a source doesn't support a claim, drop the claim.

### Flow

Issue #5 → Builder opens the ADB sources listed in Research + their own broader scan → Drafts `docs/research/adb-2026-positioning.md` → Commits → Issue #5 closes → Downstream planners (#6, #7, #8, #9) can now reference the brief as their vocabulary source of truth.

### Technical Approach

- Create `docs/research/` if it does not exist. Add a one-line `docs/research/README.md` so the directory's purpose is discoverable (or skip if the user prefers no README — see Open Questions).
- Write the brief as a single markdown file. Sections per the issue's Solution Sketch:
  1. **ADB 2026 digital priorities** — 3–5 themes. Each theme: 2–4 sentence summary + at least one source URL. Lean on the Digital Technology Directional Guide and the 2026–2028 Work Program as spine; supplement with Pacific-specific and AI-enabled-services material.
  2. **Vocabulary cheat-sheet** — 10–20 terms. Format: `**Term** — one-sentence gloss of what it signals / when ADB uses it. (source)`. Must include: digital public infrastructure (DPI), inclusive digital transformation, digital financial services (DFS), AI-enabled public services, developing member country (DMC), Strategy 2030, digital ID, Pacific subregion, "harnessing digital transformation for good". Round to 15–20.
  3. **Yudame-to-ADB angle map** — For each priority theme identified in section 1, 1–2 sentences on how Yudame threads in honestly. Explicitly flag any theme where Yudame does NOT have a credible angle — don't force-fit. Target at least 3 credible angles per the acceptance criteria.
  4. **Source links** — Consolidated list at the bottom. Every URL cited inline must also appear here.
- Register note: Include a short "Vocabulary adjustments to consider" callout flagging the "AI-forward" → "AI-enabled" register shift, so downstream copywriters see it explicitly.
- Scope discipline: The brief scopes ADB's language and maps Yudame's existing work to it. It does NOT propose new capabilities Yudame doesn't have. If a theme lacks an honest angle, say so — that absence is itself information for issues #6–#9.

## Failure Path Test Strategy

### Exception Handling Coverage
No exception handlers in scope — this is a documentation-only deliverable with no runtime code.

### Empty/Invalid Input Handling
N/A — no functions.

### Error State Rendering
N/A — no UI.

The "failure modes" for this plan are editorial, not runtime: missing sources, fabricated claims, thin vocabulary list, aspirational (vs. honest) angle map. The Success Criteria checklist addresses these directly.

## Test Impact

No existing tests affected — this is a greenfield documentation deliverable with no prior test coverage and no code changes. Validation is by inspection against the Success Criteria checklist.

## Rabbit Holes

- **Writing the downstream copy**: Do NOT start drafting homepage or practice-page copy inside this brief. The brief's job is vocabulary and theme capture; applying it is issues #6–#9.
- **Exhaustive ADB document review**: ADB publishes hundreds of documents per year. The brief is a positioning reference, not a literature review. Target 6–12 primary sources total; stop when the vocabulary cheat-sheet stabilizes (new sources stop contributing new terms).
- **Speculating on forthcoming ADB initiatives**: Stick to currently published material. Do not extrapolate "ADB will probably announce X in Q3" — brittle and aspirational.
- **Re-designing the Yudame value prop**: If the angle-mapping exercise reveals Yudame has weak angles against ADB's core themes, that's a finding to surface — not a license to invent new positioning in this doc.
- **Translating vocabulary into marketing buzzwords**: Preserve ADB's own phrasing; don't paraphrase into something slicker. The whole point is to echo ADB's voice back to ADB.

## Risks

### Risk 1: Brief becomes aspirational rather than honest
**Impact:** Downstream copy (#6–#9) inherits dishonest positioning, gets sniffed out by ADB task managers on first review, damages rather than helps vendor credibility.
**Mitigation:** Angle map explicitly allows "no credible angle for this theme" as a valid finding. Reviewer (user) checks specifically for overclaims during the one review round.

### Risk 2: Vocabulary cheat-sheet drifts from ADB's actual current register
**Impact:** Yudame copy uses ADB-adjacent but not ADB-native phrasing; lands as "someone who read one ADB doc" rather than "someone embedded in the ADB vendor ecosystem."
**Mitigation:** Anchor every term in a direct citation from an ADB publication. If a term can't be sourced, drop it. Prefer 2025–2026 sources over older ones when both exist.

### Risk 3: Downstream planners start before the brief ships
**Impact:** Issues #6–#9 get planned or built against guessed vocabulary, diverging from the brief and forcing rework.
**Mitigation:** This plan lands first. The tracking issue explicitly signals to the user that #6–#9 should wait. Coordination is the user's call, not the builder's.

## Race Conditions

No race conditions identified — documentation deliverable, single-writer, no concurrency.

## No-Gos (Out of Scope)

- Rewriting `src/index.html` (that's issue #6)
- Building case-study pages (issue #7)
- Security & compliance page (issue #8)
- Pacific telecom practice page (issue #9)
- Outreach to ADB directly (this is a positioning brief, not a biz-dev plan)
- Creating a Yudame capability that doesn't currently exist to fit an ADB theme
- Translating the brief into ADB's CMS (Consultant Management System) vendor profile — separate downstream concern

## Update System

No update system changes required — this is a repo-internal markdown deliverable, not a deployed feature.

## Agent Integration

No agent integration required — this is a static documentation deliverable.

## Documentation

### Feature Documentation
The deliverable IS documentation. No further `docs/features/` entry needed.

### External Documentation Site
N/A — this site doesn't use Sphinx/MkDocs. The brief is internal-facing and lives in the repo.

### Inline Documentation
- [ ] `docs/research/README.md` (one-line purpose statement) — OPEN QUESTION: user may prefer to skip

## Success Criteria

- [ ] `docs/research/adb-2026-positioning.md` exists and is committed
- [ ] Captures at least 3 active ADB digital priority themes, each with a source URL (issue acceptance criterion)
- [ ] Provides a vocabulary cheat-sheet of 10–20 terms with short notes on what each signals (issue acceptance criterion)
- [ ] Provides at least 3 specific angle recommendations for Yudame's positioning threaded to ADB themes (issue acceptance criterion)
- [ ] Every external claim or quote includes a source link (issue acceptance criterion)
- [ ] Vocabulary list includes at minimum: "digital public infrastructure (DPI)", "inclusive digital transformation", "digital financial services (DFS)", "developing member country (DMC)", "Strategy 2030"
- [ ] Register-adjustment note included (e.g., "AI-forward" vs "AI-enabled public services") so downstream copywriters have an explicit flag
- [ ] At least 6 distinct ADB primary sources cited (not just the ADB homepage — real documents/news items/project pages)
- [ ] Downstream issues #6–#9 can point to this brief as their vocabulary source of truth

## Team Orchestration

### Team Members

- **Builder (research-brief-author)**
  - Name: `adb-brief-author`
  - Role: Research ADB 2026 digital priorities and author `docs/research/adb-2026-positioning.md`
  - Agent Type: builder
  - Resume: true

- **Validator (brief-reviewer)**
  - Name: `adb-brief-validator`
  - Role: Verify brief meets all success criteria — sources resolve, vocabulary count in range, angle map is honest not aspirational, 3+ themes covered
  - Agent Type: validator
  - Resume: true

## Step by Step Tasks

### 1. Research and author the brief
- **Task ID**: build-adb-brief
- **Depends On**: none
- **Validates**: existence of `docs/research/adb-2026-positioning.md` with all Success Criteria items satisfied
- **Informed By**: Research section above (6 seeded findings with source URLs)
- **Assigned To**: adb-brief-author
- **Agent Type**: builder
- **Parallel**: false (single-doc deliverable)
- Create `docs/research/` directory
- Scan ADB sources: Strategy 2030 Digital Technology Directional Guide, Work Program and Budget Framework 2026–2028, Asian Development Policy Report 2025, Pacific project pages (57169-001, Fiji digital ID news), Digital Financial Services in the Pacific publication
- Identify 3–5 priority themes with source URLs
- Build 15–20 term vocabulary cheat-sheet with citations
- Draft Yudame-to-ADB angle map — honest, not aspirational. Flag any theme where Yudame lacks a credible angle.
- Add register-adjustment callout ("AI-forward" → "AI-enabled" etc.)
- Consolidate source links at bottom
- Write `docs/research/README.md` one-liner IF user answers yes to Open Question 1

### 2. Validate the brief
- **Task ID**: validate-adb-brief
- **Depends On**: build-adb-brief
- **Assigned To**: adb-brief-validator
- **Agent Type**: validator
- **Parallel**: false
- Confirm file exists at `docs/research/adb-2026-positioning.md`
- Count priority themes (>= 3), vocabulary terms (10–20 inclusive), angle recommendations (>= 3), distinct ADB sources (>= 6)
- Spot-check 3 random source URLs resolve to real ADB pages
- Read the angle map critically: flag any sentence that overclaims Yudame capability
- Verify register-adjustment callout is present
- Report pass/fail against each Success Criteria bullet

## Verification

| Check | Command | Expected |
|-------|---------|----------|
| Brief file exists | `test -f docs/research/adb-2026-positioning.md` | exit code 0 |
| Vocabulary section present | `grep -c "^## " docs/research/adb-2026-positioning.md` | output > 3 |
| Source links present | `grep -cE 'https?://(www\.)?adb\.org' docs/research/adb-2026-positioning.md` | output > 5 |
| Core DPI term included | `grep -ci "digital public infrastructure" docs/research/adb-2026-positioning.md` | output > 0 |
| Strategy 2030 referenced | `grep -ci "Strategy 2030" docs/research/adb-2026-positioning.md` | output > 0 |

---

## Open Questions

1. **`docs/research/README.md`**: Do you want a one-line purpose stub for the new `docs/research/` directory, or skip it and let `adb-2026-positioning.md` stand alone as the first entry?
2. **Source recency bias**: Should the builder prefer 2025–2026 sources strictly, or is it acceptable to cite Strategy 2030 foundational docs (2018–2019 era) when the underlying framing is still current?
3. **Register-adjustment scope**: Should the brief flag register adjustments only for terms Yudame currently uses on the site (minimal, 1–2 items), or proactively enumerate common vendor-ecosystem phrasing that diverges from ADB's register (broader, 5–8 items)?
4. **"Harnessing" / "for good" tonal register**: ADB's 2025 flagship report uses the phrase "Harnessing Digital Transformation for Good." Is that register (somewhat mission-driven, less technical) something Yudame wants to echo in downstream copy, or does it clash with Yudame's current voice? This affects how the vocabulary cheat-sheet annotates those terms.

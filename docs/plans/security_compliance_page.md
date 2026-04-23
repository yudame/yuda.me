---
status: Planning
type: feature
appetite: Small-to-Medium
owner: Valor
created: 2026-04-23
tracking: https://github.com/yudame/yuda.me/issues/8
last_comment_id:
---

# Security & Compliance Page for Vendor Due Diligence

## Problem

Institutional buyers — development banks like [ADB](https://www.adb.org), regulated telecoms, government agencies — run vendor due diligence before signing. Their checklists consistently ask for a publicly discoverable security and compliance statement. Yudame's site today has no such surface, which is a concrete blocker for vendor onboarding into systems like ADB's Consultant Management System and for most institutional engagements.

**Current behavior:**
- `yuda.me` has no `/security`, `/compliance`, or `/trust` page.
- No mention anywhere of secure SDLC practice, OWASP MASVS alignment, data protection posture, or IP/handover policy.
- Buyers performing quick due diligence find no signal and default-assume the vendor is not mature enough for institutional work.

**Desired outcome:**
- A dedicated page at `/security` (or `/trust`) that answers the common due-diligence checklist quickly and credibly.
- Every claim on the page is verified true-today. Aspirational items live on an internal roadmap, not the public page.
- Page is linked from the homepage footer, ships through the existing GitHub Pages build, and matches homepage aesthetics (Inter, yellow `#f5d563`, minimal layout).

## Freshness Check

**Baseline commit:** `9bd7765` (Revert "Migrate domain from yuda.me to yudame.org")
**Issue filed at:** 2026-04-23T10:11:50Z
**Disposition:** Unchanged — filed today, no drift.

Issue #8 was filed on the same day this plan is being written. No commits have landed on main between the issue creation and this plan. No file:line references in the issue needed to be re-verified (the issue cites concepts, not code pointers). Cross-issue references (#5 ADB brief, #6 homepage reposition) are still open.

## Prior Art

- **Commit `1cc0e68`**: "Remove QuickBooks page - site is now single-page only" — the explicit single-page stance is recent and deliberate. Adding a `/security` page is an editorial shift from that posture. Not a blocker; worth acknowledging in build copy.
- **Issue #6** (Reposition homepage copy for ADB/DMC/Pacific audience) — open. Footer link to `/security` lives on the homepage; coordinate footer changes to avoid merge conflict.
- **Issue #5** (Research ADB 2026 digital priorities and produce positioning brief) — open. Soft reference. May surface ADB-specific compliance themes worth speaking to on the security page. Not a blocker.
- No prior closed issues or merged PRs related to security, compliance, or trust pages.

## Research

**Queries used:**
- "OWASP MASVS current version 2026"
- "vendor security due diligence checklist what buyers ask for 2026"
- "ADB Asian Development Bank vendor consultant security requirements CMS"

**Key findings:**

- **OWASP MASVS current version is v2.1** ([mas.owasp.org/MASVS](https://mas.owasp.org/MASVS/), released January 2024). Defines L1 (baseline, every app), L2 (defense-in-depth for banking/healthcare/government apps), and R (resilience against reverse engineering). Plan implication: page should name v2.1 explicitly and state which level Yudame's mobile work aligns with — or, if Yudame cannot honestly claim alignment today, omit the MASVS section entirely rather than fudge.

- **Buyer-side due-diligence checklists in 2026** ([UpGuard](https://www.upguard.com/blog/vendor-risk-management-checklist), [KirkpatrickPrice](https://kirkpatrickprice.com/blog/vendor-due-diligence-checklist/)) typically ask for: SOC 2 Type II or ISO 27001 certificates, pen test summaries (no older than 12 months), incident response plans, data processing agreements, privacy policies, business continuity plans, subprocessor lists. Plan implication: Yudame almost certainly cannot claim SOC 2 or ISO 27001 today. The page must be honest about what Yudame *does* provide — secure SDLC hygiene, IP transfer, clean data-handling posture — and decline to overclaim. Credibility beats checklist completeness.

- **Emerging AI-specific concerns** ([Security Boulevard AI DD checklist 2026](https://securityboulevard.com/2026/04/ai-due-diligence-checklist-2026-how-to-avoid-ai-implementation-failures-security-risks-and-cost-overruns/)): buyers now ask whether data is used for model training, how long it is stored, who has access. Plan implication: given Yudame's AI-forward positioning, the data-protection section should explicitly speak to model-training-data handling.

- **ADB CMS specifics**: web search returned no public security checklist for ADB consultant onboarding — the portal itself (`cms.adb.org`) gates the details. Plan implication: treat ADB requirements as a generic institutional buyer baseline for now; refine later if issue #5 surfaces specifics.

## Data Flow

Not applicable — this is a static HTML page with no runtime data flow.

## Architectural Impact

- **New dependencies**: None. Reuses existing Tailwind + GitHub Pages pipeline.
- **Interface changes**: Adds one new route (`/security` or `/trust`). Homepage footer gains one new link.
- **Coupling**: No coupling increase. The new page is standalone HTML.
- **Data ownership**: None — page is static content.
- **Reversibility**: Trivial. Delete the file, remove the footer link, redeploy. No state to unwind.

## Appetite

**Size:** Small-to-Medium

**Team:** Solo dev (Valor) + Tom (subject-matter interview for true-today audit)

**Interactions:**
- PM check-ins: 1-2 (true-today audit interview with Tom; copy sign-off)
- Review rounds: 1 (credibility review of final copy before merge)

The coding is trivial. The work is concentrated in the audit and the copywriting — making sure every claim is defensible. A poorly-audited security page is worse than no page at all.

## Prerequisites

| Requirement | Check Command | Purpose |
|-------------|---------------|---------|
| Node toolchain + npm deps | `npm install && npm run build` (exit 0) | Required to build the new page through existing Tailwind pipeline |
| GitHub Pages deploy workflow passes on main | `gh run list --workflow pages.yml --limit 1` (latest run is success) | Confirms deploy path is healthy before adding a new page |
| True-today audit evidence collected | Audit notes file exists (see Step-by-Step task 1) | Non-negotiable gate before copy is written |

## Solution

### Key Elements

- **New page `src/security.html`** — Standalone HTML, matches homepage styling (Inter, yellow accent, minimal layout). Sections: posture, secure SDLC, mobile security (conditional on audit), data protection, IP transfer, security contact.
- **Homepage footer link** — One-line edit to `src/index.html` adding `/security` link in the footer.
- **Build pipeline adjustment** — If the build script explicitly lists files to copy, add `security.html` to the list. If it globs `src/*.html`, no change needed.
- **True-today audit document** — Private note (not committed to repo) capturing the practices Tom confirms Yudame actually does today. Source of truth for page copy.

### Flow

Homepage → User scrolls to footer → Sees "Security" link → Clicks → Lands on `/security` page with concise due-diligence answers → Uses contact link to ask follow-up questions.

### Technical Approach

- Static single HTML file, no JS framework, consistent with existing `src/index.html` pattern.
- Inline `<style>` block inheriting design tokens (`--yellow: #f5d563`, `--black: #0a0a0a`, Inter font) — same pattern as homepage.
- Page sections structured as an at-a-glance scannable table plus short narrative — buyers skim, they don't read.
- **MASVS section is conditional**: include only if the audit (Step 1) confirms Yudame actually follows MASVS v2.1 L1 controls in mobile work. If not, omit rather than fudge.
- **SOC 2 / ISO 27001**: do NOT claim. If the audit surfaces informal equivalents (e.g., "we follow NIST SSDF practices internally"), state those honestly with plain-language descriptions instead of certification language.
- Security contact: dedicated email alias (e.g., `security@yuda.me` or `security@yudame.org`) rather than a generic contact form — faster for institutional security teams.

## Failure Path Test Strategy

### Exception Handling Coverage
- No exception handlers in scope — this is a static HTML page.

### Empty/Invalid Input Handling
- No input handling — static page.

### Error State Rendering
- 404 behavior: if the file fails to deploy, GitHub Pages serves its default 404. Confirm post-deploy that `/security` returns HTTP 200.

## Test Impact

No existing tests affected — this is a greenfield addition to a static site with no test suite. Validation is manual: visual check in `npm run dev`, post-deploy smoke check that `https://yuda.me/security` (or chosen URL) returns 200.

## Rabbit Holes

- **Do not pursue SOC 2 or ISO 27001 certification** as part of this issue. That is a multi-quarter workstream that belongs to a separate initiative. Out of scope.
- **Do not write a formal security policy document or playbooks**. The page is a public summary, not an internal SOP library. Internal runbooks are out of scope.
- **Do not design a custom icon set or illustration for the page**. Reuse homepage visual language. This is copy-first, not design-first.
- **Do not build a contact form with backend**. A `mailto:` link to a dedicated security alias is sufficient.
- **Do not speculate about future certifications** on the public page. Aspirational language is the entire class of failure this page exists to avoid.

## Risks

### Risk 1: Aspirational / false claims ship to production
**Impact:** A single overclaimed item (e.g., "SOC 2-aligned", "full MASVS L2 coverage") on a public security page is a direct credibility hit with the exact buyer segment the page is meant to reach. Worse than having no page.
**Mitigation:** Non-negotiable true-today audit gate before copy is written. Tom reviews every claim line-by-line before merge. If a claim cannot be backed by evidence (a workflow, a repo setting, a contract clause), it does not ship.

### Risk 2: Audit reveals insufficient practices to fill the page credibly
**Impact:** If Yudame's actual-today practices don't cover enough of a buyer checklist to be useful, publishing a thin page could hurt rather than help.
**Mitigation:** Audit first, copy second. If the audit reveals gaps too large for a credible page, pause the build and escalate — the answer may be to do some practice-hardening work *before* the page ships. Better to delay than to ship a weak page.

### Risk 3: Single-page editorial stance inversion
**Impact:** Commit `1cc0e68` deliberately collapsed the site to single-page. Adding `/security` reverses that — low risk but worth flagging to the decision-maker.
**Mitigation:** Confirm with Valor/Tom that the single-page stance is not precious. Security/trust surfaces are a conventional exception; buyers expect a dedicated URL they can link to.

### Risk 4: Footer link coordination with issue #6
**Impact:** Issue #6 (homepage reposition) may rewrite the footer concurrently. Merge conflict or overwritten link.
**Mitigation:** Coordinate sequencing when both plans move to build. If #6 ships first, the security page builder adds the link to the new footer. If this plan ships first, #6 inherits the footer link in its rewrite.

## Race Conditions

No race conditions identified — static content, single-author publishing flow.

## No-Gos (Out of Scope)

- SOC 2, ISO 27001, or similar formal certification work.
- Internal runbooks, incident response playbooks, or operational security documentation.
- Contact form with backend — `mailto:` is enough.
- Custom illustration or icon set for the page.
- Aspirational / future-looking claims on the public page.
- Multi-page compliance section (FAQ, separate privacy page, etc.) — one page only for this iteration.
- Legal review of privacy-policy language — if a full privacy policy is needed later, that is a separate issue.

## Update System

No update-system changes. GitHub Pages deploys on push to main via existing workflow.

## Agent Integration

No agent integration. This is a marketing-site addition with no runtime agent involvement.

## Documentation

### Feature Documentation
- [ ] Add one-line note in repo README or `CLAUDE.md` that `/security` exists and any changes must preserve the true-today invariant.

### External Documentation Site
- Not applicable — repo has no external docs site.

### Inline Documentation
- [ ] HTML comment at the top of `src/security.html`: "Every claim below must be true-today. Aspirational items go to internal roadmap, never here."

## Success Criteria

- [ ] `src/security.html` exists and renders cleanly in `npm run dev` on desktop and mobile.
- [ ] Every claim on the page has an evidence reference in the private audit document — no exceptions.
- [ ] Homepage footer links to `/security`.
- [ ] Visual consistency with homepage confirmed (same Inter font, yellow accent, spacing rhythm).
- [ ] `npm run build` copies `security.html` into `dist/`.
- [ ] GitHub Pages deploy workflow ships the new page to production.
- [ ] Post-deploy smoke: `curl -I https://yuda.me/security` returns 200 (or 301 → 200 if chosen URL uses a trailing slash).
- [ ] Tom signs off on copy before merge.

## Team Orchestration

### Team Members

- **Auditor (true-today practices)**
  - Name: security-auditor
  - Role: Interview Tom, review actual repos/workflows, produce private audit doc enumerating true-today practices with evidence pointers.
  - Agent Type: general-purpose
  - Resume: true

- **Builder (page + copy)**
  - Name: security-page-builder
  - Role: Implement `src/security.html`, update footer, only using claims from the audit doc.
  - Agent Type: builder
  - Resume: true

- **Designer (visual consistency pass)**
  - Name: security-page-designer
  - Role: Visual QA — ensure typography, spacing, color match homepage.
  - Agent Type: designer
  - Resume: true

- **Validator (true-today gate + deploy smoke)**
  - Name: security-page-validator
  - Role: Line-by-line check that every claim on the page maps to evidence in the audit doc. Post-deploy smoke check.
  - Agent Type: validator
  - Resume: true

## Step by Step Tasks

### 1. True-today practices audit
- **Task ID**: audit-true-today-practices
- **Depends On**: none
- **Validates**: Audit doc exists with at minimum (a) secure SDLC practices Yudame actually follows, (b) MASVS alignment status (yes/no/partial, with evidence), (c) data-protection posture, (d) IP transfer default language from contracts, (e) security contact path.
- **Informed By**: Research findings (OWASP MASVS v2.1, UpGuard/KirkpatrickPrice DD checklist patterns)
- **Assigned To**: security-auditor
- **Agent Type**: general-purpose
- **Parallel**: false (blocker for all downstream tasks)
- Interview Tom (or read Tom's written notes if interview is async) on each of the six page sections.
- For each claim candidate, capture an evidence pointer: repo workflow, config file, contract clause, tool in use, etc.
- Flag any claim that cannot be backed — these do NOT go on the page.
- Output: private audit document (not committed; store path to be decided with Valor/Tom).

### 2. Draft `/security` page and footer link
- **Task ID**: build-security-page
- **Depends On**: audit-true-today-practices
- **Validates**: `src/security.html` exists; `src/index.html` footer links to it; `npm run build` succeeds and produces `dist/security.html`.
- **Informed By**: audit-true-today-practices (canonical claim list)
- **Assigned To**: security-page-builder
- **Agent Type**: builder
- **Parallel**: false
- Create `src/security.html` using homepage design tokens (Inter, `#f5d563`, minimal layout).
- Include ONLY sections backed by the audit doc.
- Include the invariant comment at the top of the file.
- Add footer link on homepage (coordinate with issue #6 if active).
- Add `security@…` mailto contact (alias TBD via open question).

### 3. Visual consistency pass
- **Task ID**: design-visual-pass
- **Depends On**: build-security-page
- **Assigned To**: security-page-designer
- **Agent Type**: designer
- **Parallel**: false
- Verify typography, spacing, color rhythm match homepage.
- Screenshot desktop + mobile breakpoints.
- Flag any visual drift.

### 4. True-today gate validation
- **Task ID**: validate-true-today
- **Depends On**: build-security-page
- **Assigned To**: security-page-validator
- **Agent Type**: validator
- **Parallel**: true (can run in parallel with design pass)
- For each claim on the page, verify a corresponding evidence row exists in the audit doc.
- Any claim without evidence → hard fail, block merge.
- Output pass/fail report with specific claim-to-evidence mapping.

### 5. Tom sign-off
- **Task ID**: signoff-copy
- **Depends On**: validate-true-today, design-visual-pass
- **Assigned To**: Human (Tom)
- **Parallel**: false
- Tom reads the rendered page end-to-end and confirms every claim.
- Gate: Tom's explicit approval in the tracking issue.

### 6. Ship & smoke-check
- **Task ID**: ship-and-smoke
- **Depends On**: signoff-copy
- **Assigned To**: security-page-validator
- **Agent Type**: validator
- **Parallel**: false
- Merge to main → GitHub Pages deploys.
- `curl -I https://yuda.me/security` returns 200.
- Confirm footer link from homepage works.

## Verification

| Check | Command | Expected |
|-------|---------|----------|
| Page file exists in src | `test -f src/security.html` | exit code 0 |
| Build succeeds | `npm run build` | exit code 0 |
| Built page exists in dist | `test -f dist/security.html` | exit code 0 |
| Footer links to security | `grep -E '/security' src/index.html` | exit code 0 |
| Invariant comment present | `grep -i "true-today" src/security.html` | exit code 0 |
| No overclaim keywords (manual review aid) | `grep -iE 'SOC 2\|ISO 27001\|certified\|compliant with' src/security.html` | exit code 1 (expected empty — flag any hit for manual review) |
| Deployed page reachable (post-deploy) | `curl -sI https://yuda.me/security \| head -n1` | output contains "200" |

## Critique Results

| Severity | Critic | Finding | Addressed By | Implementation Note |
|----------|--------|---------|--------------|---------------------|
| — | — | (Populated by /do-plan-critique if run) | — | — |

---

## Open Questions

1. **(HIGHEST PRIORITY) True-today audit evidence.** Can Tom or Valor provide an interview slot (or a written dump) enumerating: (a) specific secure SDLC practices Yudame actually does today — dependency scanning? code review gates? threat modeling? which tools? (b) MASVS alignment status for Yudame's mobile work — none / partial / L1 / L2, with evidence? (c) data-protection posture — how is client data handled in flight, at rest, in training contexts? (d) IP transfer default contract language? (e) preferred security contact alias?
2. **URL choice: `/security` vs. `/trust`?** Both are conventional. `/trust` is more common for newer SaaS (Stripe, Vercel); `/security` is more common for B2B and institutional buyers. Recommendation: `/security` given the ADB / institutional audience, but confirm.
3. **Security contact alias.** `security@yuda.me`, `security@yudame.org`, or a shared alias that forwards to Tom/Valor? Relates to the domain revert (commit `9bd7765`) — is the canonical domain `yuda.me` or `yudame.org` for contact purposes?
4. **Editorial stance check.** Commit `1cc0e68` collapsed to single-page deliberately. Confirm: is adding `/security` an accepted exception, or should the security summary live inline on the homepage instead? Recommendation: dedicated page, because institutional buyers expect a linkable trust URL. Confirm.
5. **Audit document location.** Where should the private audit doc live? Options: (a) `~/src/work-vault/Yudame/security-audit.md`, (b) a 1Password / Notion private doc, (c) git-ignored file in repo. Sensitive enough that committing it may not be appropriate.
6. **Dependency on issue #5 (ADB brief).** If issue #5 surfaces specific ADB compliance themes, do we hold this plan's build until #5 lands, or ship v1 now and iterate when #5 publishes? Recommendation: ship now, iterate — institutional-generic baseline is already useful.

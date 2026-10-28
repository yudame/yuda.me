# Plan: #yudame-dev covers yuda.me and yudame-tools

Task d6b2f65904d7. Tom, in #yudame-dev (T0B6E8JPE3C/C0CBX4MBN1L), 2026-10-28:
"we need to scope this channel to several repositories including yuda.me
company site as well as yudame-tools mac app".

This plan sits in the yuda.me workspace because that is where the task
started. The code change belongs in Valor's repo, tomcounsell/ai. Tom's
answers (2026-10-28):

1. Build it in a clone of tomcounsell/ai inside this workspace and run
   Valor's full suite there. Push the branch `valor/yudame-multi-repo` to
   tomcounsell/ai and leave main alone. Tom lands it with a message in
   #valor-dev, and a valor-project task merges it through the kernel.
2. Tom updated Xcode on the Pirate: Xcode 27.1, Swift 6.4, SDK 27.0. The
   yudame-tools spec keeps the real `swift test` suite, and the build runs
   it once against a yudame-tools checkout.

## Today

- `projects/yudame.toml` is one repo (yudame/yuda.me). It lists the channel
  in `chats` and names it as `board`. Its room line is
  `rooms."slack:T0B6E8JPE3C/C0CBX4MBN1L" = "Engineering on the yuda.me site."`.
- A chat session starts work with the `task.start` effect
  (`tools/chat_tasks.py`, `TaskStart`). The child always gets
  `project=self.project`, the session's own `{"name": ...}`, so a chat can
  only ever start tasks in its one repo.
- The Brief prints the chat's `Room:` line (`core/tasks.py`, via
  `intake.room`).

## What gets built (in tomcounsell/ai, on `valor/yudame-multi-repo`)

1. **`Spec.projects`** (`core/workspace.py`). This is a new optional key: a
   tuple of names of the other project specs that this project's chats may
   start tasks under. Each entry is checked in `from_dict` like the other
   name fields: a non-empty string with no path characters. Whether the
   named spec exists is not checked when the spec loads, because specs load
   one at a time. Also document the key in the `Spec` docstring and in
   `projects/README.md`.
2. **`task.start` takes `"project"`** (`tools/chat_tasks.py`). The payload
   gains an optional `"project": "<name>"`.
   - Without it, the child runs under the session's own project, as today.
   - With a name, the child gets `project={"name": name}` when the name is
     the session's own project or is listed in its spec's `projects`.
   - Any other name is refused by the performer's existing `refuse`, the
     same way an unknown task id is refused today. That return path already
     exists. This is the scope Tom asked for, not a new gate. Without it,
     a team channel could start tasks in any repo on the Mac, Valor's
     included.
   - The `usage` line names the optional field.
3. **The chat session sees its repos** (`core/tasks.py` Brief head). When
   the chat's project lists `projects`, a `Repos:` line follows `Room:`. It
   names each project with its repo (from its spec), the session's own
   first, and says that `task.start` takes `"project"` to choose one. The
   intended wording: "pick the one the request is about; ask in the chat
   when it is unclear". The data comes from the specs, so adding a repo
   later needs no code change.
4. **`projects/yudame-tools.toml`**. Contents:
   - `name = "yudame-tools"`, `client = "yudame"`
   - `repo` and `merge_url` = `https://github.com/yudame/yudame-tools.git`,
     `branch = "main"`, `kind = "plain"`
   - `machine = "Valor the Pirate"`, `knowledge_base = "Yudame"`
   - suite: `swift test --disable-sandbox --disable-xctest --scratch-path .build/valor --xunit-output {junit}`.
     The repo's own CLAUDE.md says SwiftPM needs `--disable-sandbox`
     inside a turn. `--disable-xctest` is needed because every test file
     uses Swift Testing only. Without the flag, `--xunit-output X` writes
     `X-swift-testing.xml` and nothing at `X`, so `read_junit` would find
     no report (critique 1, reproduced with Swift 6.4).
   - No `chats`: the channel keeps one owner.
5. **The decision board covers the listed repos** (`core/board.py`). A
   new helper, `board_spec(name)`, returns the spec itself when it names a
   `board`. Otherwise it returns the first spec on this Mac, by name, whose
   `projects` lists `name` and which names a `board`, else None.
   - `here` and `answers` resolve through `board_spec` instead of
     `spec_of`. A yudame-tools task started from #yudame-dev then counts as
     on the board: no separate question notice is sent
     (`notices.py:218`), and the board session can answer it.
   - `snapshot(spec)` matches tasks whose project is `spec.name` or any
     name in `spec.projects` (`= ANY(%s)`), so the task's open question
     appears on the #yudame-dev canvas.
6. **`projects/yudame.toml`**. Add `projects = ["yudame-tools"]`. The room
   line becomes "Engineering on the yuda.me company site (yudame/yuda.me)
   and the Yudame Tools menu-bar Mac app (yudame/yudame-tools)." Update the
   header comment and the #yudame-dev comment, citing Tom, 2026-10-28.
7. **A child reads the chat it came from** (`tools/chat_tasks.py`,
   `core/tasks.py` `brief`, `core/__main__.py` `_reading_env`). Today a
   child of a chat session carries no `chat`. Its `VALOR_CHAT` therefore
   falls back to its spec's first `chats`: the Telegram team chat for a
   yuda.me child, and nothing for a yudame-tools child.
   - `TaskStart` writes the session's own chat into the child's start
     document as `project={"name": ..., "chat": "<channel>:<chat id>"}`.
   - Provisioning rebuilds `project` from the spec, with no `chat`, and
     `tasks.brief` overlays the `workspace.provisioned` fields shallowly
     (critique 3). Without a change, `chat` would be gone from the first
     working turn. So `tasks.brief` merges `project` one level deep: the
     provisioned keys win, and start-time keys the spec does not own (only
     `chat` today) survive. The fix sits in `brief`, the one reader every
     consumer goes through. `serve.py` and `workspace.provision` stay as
     they are.
   - The child gets no top-level `chat`. That field marks a chat session,
     and provisioning would drop its setup and services.
   - `_reading_env` checks, in order: `b.chat`, then `b.project["chat"]`,
     then the spec's first `chats`. The last is today's behaviour, kept
     for tasks started from the command line or a routine.
   - `board.snapshot` and `record.py` read `body->'project'->>'name'` from
     the start document, and an extra key there does not change them
     (critique 3, confirmed on origin/main).
8. **Docs.** `projects/README.md` gets the `projects` key. It also says
   three things about that key:
   - Every chat of the listing project may start tasks in the listed
     repos.
   - The board covers them.
   - A child runs on the Mac that holds the chat session, and a listed
     project's `machine` is not consulted. So a listed project must be
     placed on the same machine as the project that lists it; a test pins
     this for the real specs.

   Beyond the README, and the
   chat-session docs that describe `task.start` (`docs/bridges/slack.md`
   and `telegram.md`, where they cover it) get one sentence each.

Adding a third repo later takes one new spec file plus one name in
`projects`, and nothing else.

**Every chat of the project, not only #yudame-dev.** `projects` belongs to
the project, so the Yudame Telegram team chat (telegram:-4719889199) also
gets the `Repos:` line. That is intended. Today that chat can already start
yuda.me tasks through `task.start`, and its room line ("No engineering or
SDLC work starts here; ... engineering requests go to the Eng group") is
what keeps it from doing engineering, for either repo. A per-chat repo list
would be a second mechanism next to `rooms` for the same concern. The
delivery names this reading.

**No new governance.** Refusing a project not listed in `projects` adds no
check, gate or refusal beyond today's scope. Today `task.start` can only
start tasks in the session's own project. The change widens that to the
listed projects, and every other repo stays out, as before. The refusal
goes through `TaskStart.refuse`, the performer's existing return path, and
no new hook, validator or approval step is added.

**Base.** Branch `valor/yudame-multi-repo` from the current
tomcounsell/ai origin/main (7ef821a6a at the time of writing, after Brew
Status folded into Yudame Tools). Run the sandboxed yudame-tools suite at
yudame-tools' current main, which now carries the Homebrew updates job.

## Out of scope

- Moving the channel, board, memory, or knowledge base away from the
  yudame project. These stay with yudame. A yudame-tools task carries
  `client = "yudame"`, so its memory is recalled with this project's.
- The Slack channel's own description, which still reads "Engineering on
  the yuda.me site". This task can't change it. The delivery names it for
  the chat session.
- Landing on main. Tom does that from #valor-dev (answer 1).

## Tests (tomcounsell/ai `tests/`)

- `Spec.from_dict` reads `projects`. It accepts a list of names, defaults
  to empty, and rejects a non-string or a name with `/`.
- `task.start` with no `project` starts the child under the session's own
  project (the existing behaviour).
- With `project` set to a listed project, the child Brief's project is
  that name. The test also provisions the child, using a local bare repo
  as that spec's `repo`, so its workspace is a checkout of that repo.
- With `project` set to the session's own name, the child runs under it.
- With `project` set to an unlisted project that exists on the Mac (for
  example `valor`), the effect is refused with a reason and no child
  starts.
- With `project` set to a name that has no spec, the effect is refused.
- A session whose project lists no `projects` passing any other name is
  refused.
- These tests go through `tasks.brief` after a `workspace.provisioned`
  row is appended (what the turn sees), not a hand-built Brief. A
  provisioned child started by `task.start` keeps `project["chat"]` and
  takes `kind`, `suite` and the rest from the provisioned fields.
- `_reading_env`: a yudame-tools child of the #yudame-dev session gets
  `VALOR_CHAT=slack:T0B6E8JPE3C/C0CBX4MBN1L`. A yuda.me child of that
  session gets the same channel, not `telegram:-4719889199`. A task with
  no `project["chat"]` keeps the spec's first chat, and a chat session
  keeps its own chat.
- Board: a yudame-tools child of the yudame board session that is waiting
  on a question appears in `snapshot(yudame spec)`. `here()` is True for
  it, so `notices` sends no separate question for it, and `answers(board
  session, child)` is True. A yudame-tools task started elsewhere, not by
  the board session, gives `here()` False. A project that names its own
  `board` resolves to itself.
- The Brief of the Telegram team chat's session (the same spec, no board)
  also carries the `Repos:` line. This pins the intended reading.
- Each project named in a real spec's `projects` has the same `machine`
  as the spec that lists it (a documented invariant, checked by a test).
- The Brief of a chat session whose spec lists `projects` carries the
  `Repos:` line with both repos. A session without `projects` has no such
  line.
- The real `projects/yudame.toml` and `projects/yudame-tools.toml` load.
  Every name in any real spec's `projects` names a spec that loads.
- Any existing test that asserts the exact `task.start` usage text or the
  Brief head is updated.

## Verification beyond the suite

- Run Valor's full suite in the clone (`uv run pytest -q -n auto`, under
  5 minutes) and `uv run ruff check .`. Report failures that also occur on
  unmodified main separately, with the evidence.
- Fetch yudame/yudame-tools with the kernel's own code (`workspace`'s
  cache and provision path, with the new spec) into a temporary
  `VALOR_WORK` on the Pirate. This shows the private repo is reachable
  with Valor's credential.
- Run the suite once the way the kernel runs it: through
  `core.checks.suite`, or failing that through `workspace.sandboxed` with
  the real harness sandbox profile, the checks layout's scratch path, and
  `turn_environment`, exactly as `checks.py` (~784) builds `argv`. Do not
  use a bare shell. Confirm three things there: the build passes under the
  sandbox, the report lands at exactly the `{junit}` path, and
  `read_junit` returns per-test results. If the sandbox blocks the build
  (for example Xcode caches outside the allowed paths), fix the spec or
  report it. Do not widen the sandbox, since that is governance.
- Push `valor/yudame-multi-repo` to tomcounsell/ai and confirm it with
  `git ls-remote`.

## Stakes

This changes how the kernel's chat sessions start tasks. A mistake could
let a team channel start work in a repo it shouldn't, or break task
starts in every chat. It lands only through a separate valor task, so it
can be reverted before it reaches any Mac.

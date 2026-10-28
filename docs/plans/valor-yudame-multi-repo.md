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
   - suite: `swift test --disable-sandbox --scratch-path .build/valor --xunit-output {junit}`
     (the repo's own CLAUDE.md says SwiftPM needs `--disable-sandbox`
     inside a turn).
   - No `chats`: the channel keeps one owner.
5. **`projects/yudame.toml`**. Add `projects = ["yudame-tools"]`. The room
   line becomes "Engineering on the yuda.me company site (yudame/yuda.me)
   and the Yudame Tools menu-bar Mac app (yudame/yudame-tools)." Update the
   header comment and the #yudame-dev comment, citing Tom, 2026-10-28.
6. **Docs.** `projects/README.md` gets the `projects` key, and the
   chat-session docs that describe `task.start` (`docs/bridges/slack.md`
   and `telegram.md`, where they cover it) get one sentence each.

Adding a third repo later takes one new spec file plus one name in
`projects`, and nothing else.

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
- Use the kernel's own code to fetch yudame/yudame-tools through
  `workspace` (`_cache` / the provision path) with the new spec, into a
  temp `VALOR_WORK` on the Pirate. Run the spec's suite command in that
  checkout and confirm it builds and produces the JUnit file. This
  confirms the private repo is reachable with Valor's credential and that
  the Pirate's new Xcode builds it.
- Push `valor/yudame-multi-repo` to tomcounsell/ai and confirm it with
  `git ls-remote`.

## Stakes

This changes how the kernel's chat sessions start tasks. A mistake could
let a team channel start work in a repo it shouldn't, or break task
starts in every chat. It lands only through a separate valor task, so it
can be reverted before it reaches any Mac.

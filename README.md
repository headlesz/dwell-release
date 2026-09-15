<p align="center">
  <img src="docs/rosette-field.png?v=1.11" width="760" alt="Thirty-two rosettes in a grid, eight list colours across, every one visibly different from the rest">
</p>

<h1 align="center">dwell</h1>

<p align="center"><em>one task. a little more headspace.</em></p>

<p align="center"><a href="https://trydwell.app">trydwell.app</a> · your next thing, quietly under the notch. right where you need it. until it's done.</p>

a to-do list shows you everything. dwell shows you one thing — in the one place your eyes
already return to a hundred times a day.

it hangs a single reminder from the notch and gets out of the way. click it for the details,
press **done** to finish it in Apple Reminders everywhere, take a breath, and choose what
comes next.

made for **macOS 26 tahoe** and later. Swift 6, SwiftUI and AppKit, one dependency for
updates and nothing else.

---

## every reminder gets a flower

<p align="center">
  <img src="docs/rosettes.png?v=1.11" width="840" alt="Twelve rosettes in a row, each five dots, all visibly different from one another">
</p>

five dots. your list's colour at the **centre** — blue for work, orange for home, whatever you
chose in Reminders. **four petals** unique to the task, grown from its own identifier, so two
reminders from the same list share a centre and differ everywhere else.

<p align="center">
  <img src="docs/pills.png?v=1.11" width="430" alt="Seven pills, each showing a task title beside its own five-dot flower">
</p>

*finish the quarterly report* and *write up the standup notes* are both blue at heart, because
they're both work — but one wears violet and indigo, the other teal and cyan. same for the
pink pair, and the orange pair. after a day or two you stop reading the pill and start
recognising it.

it's decoration that earns its place by being information, which is why the rules around it
are strict. **nothing is stored and nothing is random**: the seed is an FNV-1a hash of the
reminder's identifier, because Swift's own `hashValue` changes with every launch and would
have repainted every reminder every morning — the opposite of a familiar face. petal hues stay
within about a sixth of the colour wheel of the list's hue, so a reminder looks like it
*belongs* to its list rather than randomly recoloured.

### it turns

<p align="center">
  <img src="docs/orbit.png?v=1.11" width="760" alt="Nine frames across one revolution, the petals holding formation as they circle the centre">
</p>

the petals hold formation and circle the centre once every fourteen seconds. nine frames
above, one full turn — follow the violet petal.

four motions were built and compared before this one stayed. the most *alive* of them
scattered the petals as it moved, and lost anyway: a mark you're meant to recognise has to
keep looking like itself.

## the same flower, everywhere

<p align="center">
  <img src="docs/picker.png?v=1.11" width="430" alt="The what's next picker: three list sections, each row showing a reminder's flower beside its title and due date">
  <img src="docs/detail.png?v=1.11" width="430" alt="The detail panel: a flower beside the task title, then list, due and priority as labelled fields">
</p>

pick a new focus and the same flowers are in the list. open the one you're on and it's there
again. the menu bar icon is one too, tinted by whatever you're dwelling on.

because the rows carry the colour, the **section headers carry none**. a coloured list name
beside a row of coloured flowers is the same colour said twice, a few pixels apart. headers
are small, tracked out and grey; structure stays grey, content stays light. the detail panel
keeps the same rule — field names in the header's voice, values in light text, and no
list-colour dot anywhere, because the flower's centre already is one.

the picker's flowers are still. one turning flower is an accent; twenty is noise.

## finding and capturing

<p align="center">
  <img src="docs/search.png?v=1.11" width="430" alt="The picker in search mode, the header replaced by a query field, matching rows, and hints reading return done and esc clear">
  <img src="docs/compose.png?v=1.11" width="430" alt="The compose panel: a title field, a when field reading friday 3pm, the parsed date echoed beneath, and a target list">
</p>

**`/`** turns the header into a search and narrows the list as you type. the cursor sits on
the top match for as long as you're typing and moves only when you move it, so `return` is
always the first thing you can see. **`return`** ends the search without picking anything: the
query stays, and the letter keys go back to being commands, so you can `a`-anchor the thing
you just went looking for. selecting it is a second `return`. the header tells you which of
the two you're in — a cursor while you type, the query as plain text once it's committed — and
the hints along the bottom only ever list keys that work right now.

**`f`** filters by everything that isn't in the title. a few everyday words — `work tdy`,
`home tmrw`, `late hi`, `work tdy 5pm` — make a long list feel small:

| | |
|---|---|
| `tdy` `today` | due today **or already late** |
| `tmrw` `tmw` `tomorrow` | tomorrow only |
| `late` `od` `overdue` | overdue only |
| `mon`…`sun` · `wknd` · `wk` | that day · the next weekend · the next 7 days |
| `wkdy` `weekday` | monday to friday of the current working week |
| `someday` `undated` `nodate` | no due date at all |
| `allday` `aldy` | a date but no time — `not allday` for the timed ones |
| `hi` `high` · `med` · `low` | priority |
| `rpt` · `anchored` · `notes` | repeating · pinned to a desktop · has notes |
| `4pm` `5:30pm` `17:00` | a cutoff — *by* that time, not *at* it |
| `&` `and` | join two filters |
| `not` `!` | everything after this comes back out |
| anything else | a list name |

**`&`** (or the word `and`) puts two filters side by side: `tdy & tmrw` is both days' worth,
`work tdy & home tmrw` is *(work and today) or (home and tomorrow)*. words inside one half
narrow each other; the halves widen.

that the joining word widens is the point, not a slip. "today and tomorrow" is a request for
both days, and the narrowing reading isn't just wrong, it's useless — nothing is ever due on
two days at once, so it would always show an empty list. english *and* enumerates here.

<p align="center">
  <img src="docs/filter-joined.png?v=1.11" width="430" alt="The picker filtering on 'tdy & tmrw', showing today's, overdue and tomorrow's reminders, with the parse echoed as 'today & tomorrow'">
</p>

**`not`** (or `!`) takes things back out. `2pm not late` is everything due by 2pm without the
overdue ones; `tdy not work` is today, minus work.

it subtracts from the **result**, not from the half it was typed beside — `tdy & tmrw not
late` is *(today ∪ tomorrow) − overdue*, and the two readings differ by every overdue thing
due today. with nothing before it, `not late` simply means everything except.

<p align="center">
  <img src="docs/filter-not.png?v=1.11" width="430" alt="The picker filtering on 'tdy not late', showing today's two reminders with the overdue ones removed, echoed as 'today not overdue'">
</p>

unlike a search, a filter **stays on**. it survives picking a focus, the pill collapsing and
the panel reopening, until you press `f` again — which is why the header keeps saying `filter
work tdy` for as long as it's set, and why the hint reads `f filter off` rather than `f
filter`. a list that's short for a reason you can't see is the one thing this had to avoid.
quitting clears it; nothing else does.

a search then runs *inside* the filter, never beside it. anything the filter ruled out stays
ruled out.

words it can't place are called out in the header rather than dropped — `work zzz` shows
nothing and colours the `zzz`, because a typo that quietly changed the list would leave you
reading a shorter one with no idea why.

<p align="center">
  <img src="docs/filter.png?v=1.11" width="430" alt="The picker filtering on 'work tdy', showing two work items due today, with the parse echoed as 'work · today'">
</p>

**`r`** opens a little compose panel without leaving the notch — a title, a date typed the way
you'd say it (*tomorrow*, *friday 3pm*), and a list defaulting to the one you were looking at.
the date field echoes what it understood before you commit, and says so plainly when it
understood nothing.

<p align="center">
  <img src="docs/queue.png?v=1.11" width="430" alt="The compose panel with shift held: the add button replaced by a green queue button">
</p>

**hold shift** and **add** becomes **queue**, in green: the reminder is written but your focus
stays put, and you land back in the list rather than on the new task. capturing something
mid-task usually means you're *not* going to do it now — switching to it would undo the reason
you wrote it down — and coming back to the list leaves `r` under your finger for the next one.

the caption says `⇧⏎ to queue` before you hold anything. unlike **term**, this layer says so
up front: the reminder is written either way and only the focus differs, so there's nothing
to protect you from, and a modifier nobody knows about may as well not exist.

## a task per desktop

**`a`** anchors a task to the desktop you're on. switch Spaces and the right task is there
waiting. a grey dot means *anchored to this desktop*, so it disappears when a focus carries
onto a desktop it isn't pinned to.

the model is **one roaming focus plus any number of anchored overrides**. desktops without an
anchor share a single focus between them — what you were last doing out there — so moving
between them doesn't drag along whatever an anchored desktop was showing. that shared focus
can be nothing: press `n` out there and every unanchored desktop stays empty until you choose
again. anchored desktops override it entirely.

anchoring is deliberate in both directions: `a` pins a desktop, and choosing a different task
while you're on it un-pins it again. anchors are remembered across launches by default;
settings can make them session-only.

this is the one place dwell uses a private API, and not by choice. macOS publishes nothing for
"which desktop is this". the public `com.apple.spaces` preference looks like it knows, but it
tracks desktops being created and reordered, not switched between — verified by watching it
sit unchanged through real switches. so the active desktop comes from a private CoreGraphics
call, resolved at runtime rather than linked, which disables anchoring on any macOS that stops
vending it rather than breaking the app. it also means dwell can't go to the App Store as-is.

## finishing something

<p align="center">
  <img src="docs/encouragement.png?v=1.11" width="520" alt="A pill reading 'look at you go' with a colour gradient flowing through the letters">
</p>

press **done** and the reminder completes in Reminders on every device. then its flower comes
apart: forty-odd dots in its own petal colours thrown up out of the notch and drifting down the
screen, while the pill shows one of sixty short phrases — *nice*, *look at you go*, *no
notes*, *off your plate* — with those same colours flowing through the letters. three and a
half seconds, then, when you're ready, what's next?

<p align="center">
  <img src="docs/term.png?v=1.11" width="430" alt="The detail panel with shift held: the done button replaced by a red term button">
</p>

**hold shift** and **done** becomes **term**, in red. that one completes the reminder and then
deletes it — for the things you want gone rather than filed. it has to be its own verb rather
than a checkbox on *done*, because completing a *repeating* reminder rolls it forward to its
next occurrence; removing the series is the only way to actually be rid of one. it completes
first and deletes second, so a failed delete leaves you with a finished reminder rather than an
untouched one.

there is no undo. the red is the whole warning.

when nothing is set the pill says something quiet instead — *take your time*, *no rush*, *the
list can wait*, one of fifty-five. a different register on purpose: the celebration is warm
about what you just did; these are calm about the fact that you're not doing anything. an
empty pill is not a backlog. it's room to think.

## the whole screen, when you want it

<p align="center">
  <img src="docs/presentation.png?v=1.11" width="720" alt="The fullscreen view: one large rosette above the task title and the current time, centred on black">
</p>

**⌘⌥⇧`** takes the flower and the title to every display at once, like a screen saver, with
the time underneath. just you, and one thing. the cursor goes away. with nothing set, the quiet
phrase takes the title's place rather than the chord appearing to do nothing.

the clock is 12- or 24-hour depending on your system setting, which it reads rather than
duplicates — there's no preference here to fall out of step with the menu bar. minutes, not
seconds: a second hand is movement, and the only thing meant to move is the drift.

which is two offsets on 97- and 61-second periods, so the path wanders instead of sliding along
one line, and never visibly repeats.

any key or movement brings you right back: a click, a scroll, or the mouse moving more than a
few points. it ignores the first half-second, because your hand is still on the trackpad from
pressing the chord.

## settings

<p align="center">
  <img src="docs/settings.png?v=1.11" width="430" alt="The settings window: a sidebar listing settings, license and about, with two rebindable shortcut rows, desktop, startup and update controls">
  <img src="docs/license.png?v=1.11" width="430" alt="The license pane: trial with two days left, a key field with an activate chip, and the buy link">
</p>

**⌘⌥`** opens the current task's actions from anywhere — or what's next, if nothing is set.
**settings…**, in the menu bar, is where both chords are rebound. that window exists because an
`NSMenu` can't record a key chord; a window that takes keyboard focus can, so it captures
whatever you actually press — and arming one recorder disarms the other, or they'd both swallow
the same keypress.

both use Carbon's `RegisterEventHotKey` rather than watching the keyboard globally, which would
need Accessibility permission — dwell asks for nothing beyond Reminders.

**updates take care of themselves.** dwell checks once a day and, when there's a new version,
downloads it, verifies its signature, swaps itself out and relaunches quietly — no prompt,
because a pill that runs until the Mac does would otherwise never get to install one. the same
pane has *check now* and a switch to turn the automatic checks off.

**three days free, then $8, once.** dwell runs exactly as it does now for three days and never
mentions it; *settings → license* keeps count. after that the pill says *trial's up* and
clicking it opens that pane instead of the picker. one key covers three Macs, and *deactivate
this mac* frees a slot when one is sold. the record lives in the Keychain, so deleting the app
doesn't restart the clock, and a clock rolled back reads as expired. dwell talks to
[trydwell.app](https://trydwell.app) for exactly three things — activating a key, checking it
weekly, and freeing a slot — sending the key, a device id and the Mac's name. never a
reminder. if the service can't be reached, the last answer stands for thirty days.

## the rest of it

the pill never moves: not when an app goes fullscreen, not across Spaces, not when another app
is frontmost. it never takes focus and never intercepts a click outside its own silhouette. a
guest on your screen — always there, never in the way.

<p align="center">
  <img src="docs/marquee.png?v=1.11" width="560" alt="A pill at its maximum width, the title cut off with a soft fade on the right before the anchor dot">
</p>

**it's never wider than Alcove is with music playing** — the notch plus 37pt each side, so it
keeps Alcove's proportions on any MacBook. a title that doesn't fit **scrolls**, the way iOS
Now Playing does: it holds for three seconds, travels left at 32 points a second, and a second
copy is already where the first began, so it wraps without ever reversing. the rosette and the
anchor dot stay put; only the text moves, with a soft edge where it leaves and arrives. a title
that fits is left alone. Reduce Motion never scrolls.

**right-click** (or two-finger click) fades the pill when it's covering something you need to
read, and while it's faded clicks pass straight through to whatever's underneath. it holds for
as long as your cursor stays there; move away and it returns, come back mid-fade and it drops
out again. no second click, ever.

**keyboard**, once a panel is open:

| | |
|---|---|
| detail | `tab` reveals the cursor on **done**, so finishing is `tab` then `return` |
| detail | `shift` turns **done** into **term** — completes it, then deletes it |
| compose | `shift` turns **add** into **queue** — writes it without focusing it |
| picker | `↑`/`↓` (or `k`/`j`) a row · `tab` next list · `return` select |
| picker | `/` search · `f` filter · `r` new · `a` anchor · `n` nothing |
| typing | `return` ends entry and keeps the query · `esc` clears it |
| filter | `f` again turns it off — it is the only thing that does |
| filter | `&` or `and` joins two — `tdy & tmrw` is both days |
| filter | `not` or `!` subtracts — `2pm not late` drops the overdue |
| either | `esc` steps back one thing at a time, and closes when there's nothing left |

**global**: ``⌘⌥` `` opens the actions · ``⌘⌥⇧` `` goes fullscreen

## buy

**three days free, then $8, once.** the trial is the whole app and never mentions itself;
after three days the pill says *trial's up* and waits for a key. one key covers three Macs,
every future update is included, and there's a fourteen-day refund with no reason needed.

**[buy dwell · $8](https://buy.stripe.com/aFafZi28U95b5J50Rx6c000)** — the key is on the page
after checkout and in your email. [terms](docs/TERMS.md) · [privacy](docs/PRIVACY.md): what
the license service keeps, and that nothing about your reminders ever leaves your Mac.

everything above, and a little demo you can click, lives at **[trydwell.app](https://trydwell.app)**.

## install

download **[dwell.zip](../../releases/latest)**, unzip it, and drag `dwell.app` into
`/Applications`. it's signed and notarized, so it opens on a double-click.

run it from `/Applications`: the path has to be stable for the Reminders permission to stick,
and `SMAppService` expects it there.

macOS asks for Reminders access on first launch, and for nothing else. there's no dock icon and
no window — dwell lives in the pill and in a menu bar item, a small rosette in the current
task's colours, which tells you what you're **dwelling on**, completes it, offers a list to
**dwell on** next, opens settings, and quits. that menu is also the accessible path: a panel
that only takes keyboard focus while open is hard for VoiceOver to reach, so everything the
pill can do, the menu can do.

## what EventKit can't see

subtasks, tags, flags, attachments, the URL you attach in the Reminders app, smart lists, and
the manual sort order are all invisible to EventKit. open Reminders for those. the picker's
ordering is therefore computed: soonest deadline, then priority, then title.

---

made by [mikey boyd](https://mikeyboyd.com) with ❤️ · [trydwell.app](https://trydwell.app)

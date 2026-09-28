# Brightness settings (firmware 0.5.0)

Use **Settings → Brightness** on the controller. The five controls share a
normalized 0–100% scale, with 5-point knob steps. Level edits and Reset default
are drafts until Save; Cancel, hold and idle timeout discard them. Local output
previews use the draft without writing flash. Sign settings are read afresh when
opening either sign control and applied only by Save. A failed save requires a
fresh read; it is never replayed automatically.

## Ranges and defaults

| Control | Native minimum | Native default | Native maximum | Displayed default |
| --- | --- | --- | --- | --- |
| Sign frame | 50 permille (5%) | 160 permille (16%) | 500 permille (50%) | 50% |
| Sign indicator | 50 permille (5%) | 125 permille (12.5%) | 250 permille (25%) | 50% |
| Screen awake | Contrast 41 | Contrast 207 (`0xCF`) | Contrast 207 | 100% |
| Screen dim | Contrast 0 | Contrast 0 | Contrast 40 | 0% |
| Controller light | 13/255 (about 5%) | 24/255 | 76/255 (about 30%) | 50% |

The mapping in `src/brightness.c` uses monotonic linear segments below/above
the default, preserving the exact old drive values. Displayed percentages are
positions in each adjustment range, not electrical or measured optical output.
The OLED's previous `display.dim(true)` selected contrast zero; this remains a
lit display, distinct from DISPLAYOFF. The new awake minimum is about 20% of
the old normal contrast; dim always stays below awake. Existing 30-second dim,
two-minute sleep and wake-only first gesture behavior remains.

LED adjustment scales the actual current raw color. It does not change the mood,
restart Special/Request, or disturb the independent indicator's blink phase.
Unchanged settings do not refresh output. The receiver's temporary pixel test
also respects frame brightness. Existing onboard RGB calibration is retained.

## Wire and storage contract

The version-1 six-byte mood protocol is unchanged. An appended encrypted
read/write characteristic, `7f6c0005-6b7e-4c80-9f2a-f9b9d7e2a601`, exchanges
seven bytes: version `1`, nonzero 32-bit little-endian transaction ID, normalized
frame level, normalized indicator level. Reads use the same layout; transaction
zero denotes defaults before a save. Writes require the bonded encrypted peer
and validate length, offset, version, transaction and both 0–100 levels.

The receiver persists both levels atomically, applies output, then advances its
readable state. The controller requires an exact transaction AND both-level
match from a fresh read after writing; ATT success or an old snapshot does not
confirm a save. An exact duplicate is idempotent, including after reboot;
reusing the current ID with different values is rejected. Ordinary mood traffic
does not read or write brightness. An older sign reports **Update sign firmware**
when its brightness characteristic is absent; update the pair together.

Receiver NVS key `loa_light/levels` stores the seven bytes plus CRC-8/ATM
(polynomial `0x07`, initial zero). Controller Preferences key
`loa-desk/brightness` stores five bytes: version `1`, awake level, dim level,
controller LED level, CRC-8/ATM. Missing keys need no migration: they select the
old firmware's exact defaults. Invalid length, schema, checksum or range also
falls back to defaults. No mood/bond record or partition changes are needed.
Pair/Forget and the five-reset pairing recovery preserve brightness.

A storage failure prevents output application. Output failure prevents a new
acknowledgement/readable state; output rolls back on a best-effort basis. Because
persistence precedes application, an interrupted or unconfirmed save may become
active on the next boot. Reload after uncertainty rather than assuming that the
old setting remained saved. Boot applies stored brightness before the saved mood.

<a id="validation-and-next-bench-pass"></a>

## Validation and bench coverage

Host tests exercise native bounds and exact defaults, malformed packets/records,
exact acknowledgement matching, editor limits/reset drafts, local-record reload,
and the real receiver settings/output adapters with simulated flash and driver
failures. They cover duplicate transactions before/after reboot, an interrupted
apply, corrupt/truncated storage, indicator isolation, animation-frame retention
and pixel-test restoration. The actual-GFX renderer checks every brightness
label, action, range endpoint, busy and error layout and emits 23 screen previews.
The controller menu suite runs the actual application loop with fake hardware,
storage and transport boundaries, including preview cancellation, failed local
saves, remote reload after uncertainty, timeout, boot restore and sleep behavior.

The implementation and digital validation were completed without devices
attached. The subsequent [September 27 hardware bench](BRIGHTNESS_BENCH.md)
records flashing, physical observations and outstanding checks. Digital
validation cannot establish perceived brightness, current consumption or
physical persistence on the assembled devices. The hardware checklist is:

1. Upgrade both applications while preserving NVS/bonds, then verify pairing,
   mood and all five default levels match the previous behavior.
2. Exercise each endpoint, Save, Cancel, Reset default and idle timeout. Check
   awake/dim/sleep visibility and the wake-only gesture.
3. Save non-default values, disconnect and power-cycle each device separately;
   re-enter both sign controls and verify fresh reads and retained levels.
4. Save while the sign becomes unreachable; verify uncertainty is shown and no
   command is replayed. Reconnect and reload the actual settings.
5. Verify Off, Request, Special, the independent red indicator and local light
   test at low/high levels. Check the 50% frame ceiling optically/electrically
   in the documented power arrangement before considering it physically validated.

Follow [the existing bench connections](PAIRED_BENCH.md#connections). Record
actual observations separately from build/test results.

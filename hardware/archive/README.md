# Hardware archive

This directory preserves superseded designs and intermediate work. For current
builds, use [the hardware index](../README.md).

## Receiver enclosure

`enclosure/` retains the historical internal layout from
`hardware/enclosure/`: versions v2 through v2.15, early builders, release
templates, component references, reviews and their `output/` trees. The four
one-time v2.16 patch/probe scripts are in `enclosure/v216/`; their final changes
are already incorporated in the current builder.

- [Revision history with updated artifact links](../enclosure/REVISION-HISTORY.md)
- [v2.15 notes](enclosure/v215/README.md)
- [v2.14 notes](enclosure/v214/README.md)
- [v2.13 notes](enclosure/v213/README.md)
- [Early design review](enclosure/DESIGN-REVIEW.md)
- [Historical generated output](enclosure/output/)

The active v2.16 tools explicitly load a few geometry, mesh and G-code helpers
from this archive. Those dependencies are intentional.

## Controller

- [Igor v1](controller/igor-desk-v1/README.md)
- [Igor minimal v2](controller/igor-minimal-v2/README.md)
- [Igor flat-base v3](controller/igor-flat-base-v3/README.md)

Each directory retains its source, CAD, manufacturing files and internal
package manifest. The current [measured v4](../controller/igor-measured-v4/README.md)
remains outside the archive.

## Using historical snapshots

Files moved here retain their original bytes. Historical manifests, absolute
paths, links to locations outside a snapshot, and one-time scripts can refer to
the old layout. For exact historical regeneration, use a separate checkout of
commit `b6d09577b0ada5e0c453e3eb21bf7bbf04e6821e`, the complete pre-cleanup tree.
Use current tooling for new work rather than running an old release script
against today's release directory.

Published bundles and checksums remain under [release/](../../release/README.md).

# Naadan Adi 3D — Build Plan

## Phase 0 — Foundation
- [x] Create isolated fresh-development branch.
- [x] Record 3D / English-default / Malayalam-option decisions.
- [ ] Open and validate the project in Godot 4.x (Godot executable is not available in this workspace).
- [ ] Pin exact Godot version and Android export template version.

## Phase 1 — Playable offline prototype
- [x] Add preliminary third-person CharacterBody3D movement, gravity and jump source.
- [x] Add follow camera, mouse look and touch-drag camera source.
- [x] Add greybox arena floor, collision, player spawn and primitive Kerala-inspired dressing.
- [x] Add damageable target dummy and prototype hitscan test weapon source.
- [x] Add prototype health/ammunition display, magazine and reload timing source.
- [ ] Run and validate all scenes/scripts in Godot 4.x.

## Phase 2 — Android controls
- [x] Add source for left virtual movement stick.
- [x] Add source for right-side camera drag / aim region.
- [x] Add source for fire, jump and reload buttons (sprint not yet implemented).
- [ ] Simultaneous movement + camera + fire + jump.
- [ ] Sensitivity, dead-zone and control layout settings.
- [ ] Test on at least one real Android phone; tune for low/mid-range devices.

## Phase 3 — Kerala identity
- [x] Add simple main menu with English default and English/Malayalam toggle source.
- [ ] Full lobby, profile and settings screens.
- [ ] Expand localization into reusable language resources and test Malayalam font rendering.
- [ ] Original character model, rig and animations.
- [ ] First fictional Kerala hill-village arena with full collision.
- [ ] Sound, UI feedback and accessibility settings.

## Phase 4 — Multiplayer
- [ ] Define and document a new 3D client/server protocol.
- [ ] Verify server compatibility; adapt or replace old server code as needed.
- [ ] Private rooms for 2–6 players.
- [ ] Server-authoritative damage, kills, scores and match lifecycle.
- [ ] Reconnect, timeout, latency and multi-client tests.

## Phase 5 — Release
- [ ] Crash/performance test on supported Android devices.
- [ ] Privacy policy and Data Safety based on actual SDK/data inventory.
- [ ] Store icon, screenshots, feature graphic and listing.
- [ ] Secure signing keystore and build signed AAB.
- [ ] Internal testing track, fix feedback, then production submission.

## Current honest status
The branch contains architecture and build-plan documents only at this stage. No verified playable client, APK/AAB, Android device test or completed 3D art is claimed.

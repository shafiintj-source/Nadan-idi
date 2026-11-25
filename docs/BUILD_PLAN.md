# Naadan Adi HD — 2026 Build Plan

## Phase 0 — Project identity and foundation
- [x] Create isolated fresh-development branch.
- [x] Create 2026 upgrade brief.
- [x] Replace Malayalam-heavy prototype entry labels with compact English-first menu source.
- [ ] Identify the installed Android APK package/version and confirm whether its source matches this repository.
- [ ] Import and validate project in Godot 4.x; pin engine and export-template versions.

## Phase 1 — Offline playable vertical slice
- [x] Add preliminary third-person movement, gravity and jump source.
- [x] Add follow camera and mouse/touch look source.
- [x] Add greybox arena, collision, player spawn and placeholder Kerala dressing.
- [x] Add target dummy and prototype hitscan weapon source.
- [x] Add basic health/ammo HUD and reload timing source.
- [ ] Parse/run all scenes and scripts in Godot; resolve all runtime errors.
- [ ] Tune simultaneous movement, aim, fire, jump and reload on Android.
- [ ] Add sprint, hit feedback, sound and a complete training loop.

## Phase 2 — UI and customization
- [x] Compact English-first entry menu source.
- [ ] Stable modern lobby and reproduce/fix startup issue on actual target build.
- [ ] Functional weapon loadout, attachments, skins and upgrades.
- [ ] Functional character customization: outfit, helmet and backpack.
- [ ] Map/mode selection with preview cards.
- [ ] Settings: graphics, audio, sensitivity, control layout and accessibility.
- [ ] Short optional voice commands with explicit microphone permission and touch alternatives.

## Phase 3 — Kerala maps and gameplay
- [ ] First polished fictional Munnar-inspired map with cover, routes, verticality and landmarks.
- [ ] Fort Kochi-inspired harbour map.
- [ ] Backwater village map.
- [ ] Western Ghats forest / hill-road map.
- [ ] Original optimized characters, rigs, animations, weapons, VFX and sound.
- [ ] Bots, match timer, health, ammo, scoring and results.
- [ ] Low/mid/high Android graphics presets and performance profiling.

## Phase 4 — Multiplayer
- [ ] Define a new 3D client/server protocol.
- [ ] Audit and adapt or replace legacy server; do not assume 2D protocol compatibility.
- [ ] Private rooms for 2–6 players.
- [ ] Server-authoritative movement validation, damage, kills, score and match lifecycle.
- [ ] Reconnect, timeout, latency and multi-client tests.

## Phase 5 — Android release
- [ ] Debug APK export and installation test.
- [ ] Crash, thermal, memory and frame-rate tests on supported Android phones.
- [ ] Signed release APK/AAB using securely stored signing material.
- [ ] Store icon, screenshots, feature graphic, privacy policy and Data Safety review.
- [ ] Upload a verified build to Drive and confirm its download link.

## Current honest status
Source and planning documents are committed, and the entry-menu source has been simplified. The project has not been run in Godot. There is no verified playable build, fixed installed APK, production-quality map, multiplayer release or APK/AAB yet.
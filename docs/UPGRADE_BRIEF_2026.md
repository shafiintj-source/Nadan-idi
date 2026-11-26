# Naadan Adi HD — 2026 Upgrade Brief

## Product direction
Upgrade the current Naadan Adi concept into an Android-first, polished 3D third-person multiplayer arena shooter. This brief is a target specification, not a claim that these features are implemented or tested.

## UX and language
- English-only visible UI by default; avoid long Malayalam text and Malayalam-heavy typography.
- Short optional English voice-command vocabulary: Fire, Reload, Jump, Follow, Help.
- Voice commands must be opt-in, work only after explicit microphone permission, and have touch-button equivalents.
- Rebuild the opening flow as a stable, responsive landing screen leading to a modern lobby. The reported opening-screen bug must be reproduced on the actual installed APK or source build before calling it fixed.
- Use readable Latin fonts, strong contrast, scalable UI, safe-area support and landscape-first layouts.

## Customization UX
- Dedicated Loadout screen for primary/secondary weapons, attachments, skins and upgrades.
- Character screen for outfit, helmet, backpack and appearance.
- Map/mode selection screen with clear cards and preview art.
- Settings for sensitivity, graphics quality, audio, control layout and language/voice options.
- All controls must be functional; do not show fake selectable options.

## Gameplay target
- Third-person 3D movement, aim, fire, jump, reload and optional sprint.
- Bots, health, ammo, scoring, match timer and results.
- Initial online rooms for 2–6 players, with server-authoritative match state, damage and scoring.
- Offline training range available while multiplayer is unavailable.

## Kerala map direction
Build original, fictional, optimized environments inspired by Kerala rather than copying real protected game maps:
1. Munnar tea estates and hillside settlement.
2. Fort Kochi-inspired harbour streets and waterfront.
3. Backwater village with canals, bridges and coconut groves.
4. Western Ghats forest / hill-road combat zone.
5. A later festival-ground map inspired by Kerala's public-square architecture, without using protected event branding.

Maps should feel large through readable routes, verticality, landmarks, interiors, cover, flanking routes and performance-aware streaming—not just empty acreage.

## Visual quality
Aim for a modern mobile-game presentation: cohesive lighting, materials, silhouettes, VFX, sound feedback, animation and polished menus. Use scalable quality presets for low-, mid- and high-range Android devices. No claim of better than Mini Militia until side-by-side playtesting supports it.

## Delivery gates
1. Identify the installed APK's package/version and obtain the matching source project if the goal is to repair that exact app.
2. Confirm the actual engine and reproduce the startup issue.
3. Validate the current Godot prototype in Godot 4.x, or migrate deliberately if the matching source is Unity.
4. Complete one polished offline vertical slice before expanding maps or online play.
5. Test touch controls and performance on a real Android phone.
6. Implement and load-test 2–6 player networking.
7. Produce a debug APK, test it, then create a signed release APK/AAB.
8. Share a Drive link only after a real build is uploaded and its download is verified.

## Important limitation
An installed APK is a compiled package, not the editable source project. It may be inspected for package/version information, but modifying its original UI and gameplay reliably requires its matching source project and assets. The existing GitHub branch fresh-3d-foundation is a separate Godot 4 prototype foundation; it has not yet been opened or run in Godot and is not confirmed to be the source of the installed APK.
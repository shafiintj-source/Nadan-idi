# Naadan Adi HD — Client project status

## Fresh development branch
Branch: fresh-3d-foundation
Repository: https://github.com/shafiintj-source/Nadan-idi/tree/fresh-3d-foundation

## Latest changes
- Added docs/UPGRADE_BRIEF_2026.md and docs/TOUCH_MAP_CUSTOMIZATION_UX.md for the 2026 upgrade direction, visual-card loadout selection, touch layout and map design.
- Reworked scripts/main_menu.gd to remove Malayalam-heavy menu labels and use a compact English-first NAADAN ADI HD entry screen with PLAY and EXIT.
- Expanded the greybox arena floor from 40 x 40 to 120 x 120 world units; moved the player spawn and training target farther apart.
- Added touch RUN and SWAP controls; added sprint speed and prototype Assault Rifle / SMG switching to the player controller.
- Added a LOADOUT entry to the main menu and a card-based Weapons / Skins / Character / Maps selection screen. Current selections are prototype UI state only; persistent inventory and actual character/weapon assets are not wired yet.
- Kept keyboard/mouse controls active for desktop editor runs; touch controls are selected on Android/iOS.
- Added perimeter collision walls, four house-like structures, cover lanes, palm silhouettes and distant green hills to support multiple routes and more controlled fights.
- Added a scene-change error log if the prototype arena cannot be opened.

## Existing prototype source
- Godot 4 project configuration and landscape-first mobile renderer settings.
- Prototype greybox arena, capsule player, target dummy and procedural placeholder Kerala village dressing.
- Preliminary third-person movement, camera, hitscan, health, ammo and reload source.
- Preliminary touch joystick, camera drag, fire, jump and reload HUD source.

## Important distinction
The APK already installed on the user's Android phone has not been identified as this repository build. The user reported an opening-screen bug, but the exact APK/package/version and matching source project are not yet available. The fresh Godot branch is a separate prototype foundation and must not be described as a repaired version of the installed APK.

## Verification status
**Not runtime-verified.** Godot is not installed in the current coding workspace. The project has not been imported, parsed or run in Godot. No APK/AAB has been built, no Android device test has been completed, and no Drive upload exists.

## Not yet implemented or verified
- Polished 3D character models, rigging, animations and weapon models.
- Persistent inventory/loadout save data, actual weapon/skin assets and functional in-match equip application.
- Functional loadout, attachments, skins, character customization and settings screens.
- Large production-quality Kerala maps; current environment is only primitive placeholder dressing.
- Voice recognition; proposed short commands are Fire, Reload, Jump, Follow and Help. Microphone permission and touch alternatives must be implemented.
- Bots, match lifecycle, scoring and results.
- 2–6 player 3D networking; old server is not verified compatible.
- Startup issue on the installed APK; requires reproduction on the matching build.
- Android APK/AAB export, signing, performance testing and Play Store assets.

## Required delivery sequence
1. Identify installed APK package name/version and locate matching source if repairing that exact app.
2. Open and validate the fresh Godot branch in Godot 4.x; fix parse/scene errors.
3. Complete one polished offline vertical slice and test touch controls on a real Android phone.
4. Add functional loadout, character, settings and map selection.
5. Build the first optimized Kerala map and basic bots/match loop.
6. Implement and load-test server-authoritative 2–6 player multiplayer.
7. Build and test a debug APK, then create signed release APK/AAB.
8. Upload only a real verified build to Drive and share its working link.

## Security
Never commit keystores, passwords, export credentials, API tokens or private signing material.
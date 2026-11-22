# Naadan Adi 3D — Client project status

## Fresh development branch
Branch: `fresh-3d-foundation`

## Source files added
- `project.godot` — Godot 4 mobile renderer configuration and prototype main scene.
- `scenes/prototype_arena.tscn` — greybox floor, light, environment, player, target and touch HUD.
- `scenes/player.tscn` — CharacterBody3D capsule placeholder, camera pivot and spring arm.
- `scenes/target_dummy.tscn` — damageable target for aim testing.
- `scripts/player_controller.gd` — preliminary camera-relative movement, jump, mouse/touch camera, hitscan, health, ammo and reload timing.
- `scripts/mobile_controls.gd` — source for left virtual joystick, right-side look drag, fire/jump/reload touch buttons and basic HP/ammo HUD.
- `scripts/kerala_arena_dressing.gd` — procedural primitive placeholders inspired by Kerala village buildings, palms and green hills.
- `docs/ARCHITECTURE.md` and `docs/BUILD_PLAN.md` — architecture and staged completion criteria.
- `.gitignore` — excludes generated builds, Godot cache and private signing credentials.

## Decisions
- 3D third-person arena shooter.
- English default; Malayalam option planned.
- Android-first.
- 2–6 player online rooms planned.
- First milestone: offline playable prototype.

## Verification status
**Source has been committed, but not executed.** No Godot executable is installed in the current coding workspace, so the project has not been imported, parsed or run in the Godot editor. Scene/script compatibility is therefore not yet verified.

## Not yet implemented or verified
- Final character model, rig and animations.
- Polished production-quality Kerala map art and level design.
- Weapon models, muzzle effects, sound and full combat feedback.
- Bots, match rules, scoring, lobby, profile, language selector and settings UI.
- 3D multiplayer protocol/client integration. The legacy server is not assumed compatible.
- Android APK/AAB, export templates, signing and real-device tests.
- Play Store release assets and final Data Safety answers.

## Required next actions
1. Open this branch in Godot 4.x; fix parser/scene errors.
2. Verify project orientation and Android export settings.
3. Test movement, camera, collision, touch controls and aim on a real Android device.
4. Add a language selector and English/Malayalam text resources.
5. Replace primitive environment placeholders with optimized original 3D assets.
6. Implement weapon handling, bots, match loop and results.
7. Design and test a 3D client/server protocol for 2–6 players.
8. Perform performance, crash and multi-client tests.
9. Build debug APK, then signed release AAB using securely stored signing material.

## Security
Never commit keystores, passwords, export credentials, API tokens or private signing material.

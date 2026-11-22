# Naadan Adi 3D

Fresh 3D third-person arena-shooter prototype for Android.

## Accepted decisions
- 3D third-person shooter.
- English default; Malayalam language option planned.
- Android-first; 2–6 players planned for online rooms.
- First milestone: a small offline prototype with movement, camera, target practice and touch controls.

## Open the fresh Godot project
Open this repository's root folder in Godot 4.x. The main scene is configured as `res://scenes/prototype_arena.tscn`.

Current prototype source:
- `scenes/player.tscn` and `scripts/player_controller.gd`
- `scenes/target_dummy.tscn` and `scripts/target_dummy.gd`
- `scripts/mobile_controls.gd`
- `scripts/kerala_arena_dressing.gd`

## Development documents
- [Fresh 3D README](README_FRESH_3D.md)
- [Architecture](docs/ARCHITECTURE.md)
- [Build plan](docs/BUILD_PLAN.md)
- [Client project status](CLIENT_PROJECT_STATUS.md)

## Legacy multiplayer server
The existing `server/`, `scripts/match.gd`, `scripts/wire.gd`, Docker and Render files are retained from the earlier project. They are **not yet verified as compatible** with the new 3D client. Do not treat the previous 2D server protocol as connected to this prototype.

## Verification status
The new Godot source scaffold has been committed, but it has not yet been opened or run in the Godot editor. No APK/AAB or Android device test is available from this branch. Godot 4.x editor validation is the next required step.

Never commit signing keystores, passwords, export credentials, API tokens or private secrets.

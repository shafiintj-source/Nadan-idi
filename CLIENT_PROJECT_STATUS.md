# Naadan Adi 3D — Client project status

## Repository audit
The legacy `main` branch contains the earlier multiplayer-server/deployment subset and release planning files. It did not contain a complete playable game client.

## Fresh branch created
Branch: `fresh-3d-foundation`

Added a starter Godot 4 project structure:
- `project.godot` — mobile renderer configuration and main scene.
- `scenes/prototype_arena.tscn` — greybox floor, lighting, environment and player spawn.
- `scenes/player.tscn` — CharacterBody3D placeholder capsule, camera pivot and spring arm.
- `scripts/player_controller.gd` — preliminary keyboard movement, jump and mouse-look for editor prototype.
- `docs/ARCHITECTURE.md` — accepted 3D architecture and game direction.
- `docs/BUILD_PLAN.md` — staged build and release gates.
- `.gitignore` — excludes Godot cache, builds, signing keys and export presets.

## Decisions
- 3D third-person arena shooter.
- English default, Malayalam optional.
- Android-first.
- 2–6 players planned.
- First milestone is one offline greybox arena and responsive controls.

## Not yet verified / not yet implemented
- The new scaffold has **not** been opened or run in the Godot editor; GDScript and scene files require validation.
- No Android touch UI yet. Current controller is keyboard/mouse only for an editor prototype.
- No final character model, animations, weapons, map art, UI screens, audio, bots or gameplay loop.
- No 3D multiplayer client protocol or integration.
- No APK/AAB, signing setup or Android device test.

## Next required work
1. Open this branch in Godot 4.x and fix any parser/scene errors.
2. Confirm exact Godot version and Android export template.
3. Add camera-relative movement polish, acceleration, jump and collision test.
4. Build mobile virtual joystick, camera drag, fire, jump and reload controls.
5. Add target dummy and one test weapon.
6. Create first original Kerala-inspired arena art after greybox gameplay works.
7. Design and verify the 3D client/server protocol before enabling online play.
8. Perform real Android device and multi-client tests before release claims.

## Security
Never commit keystores, passwords, export credentials, API tokens or private signing material.

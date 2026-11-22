# Client project status and handoff

## Repository audit (2026-11-22)
The default branch currently contains server/deployment material and release notes, including:
- server/main.gd
- scripts/match.gd
- scripts/wire.gd
- deployment/server-project.godot
- Dockerfile and render.yaml
- release checklist, store listing draft, package ID and data-safety review worksheet

The repository listing does **not** currently show a complete Godot client project. In particular, no root client project.godot, client scenes, player/controller scripts, map scenes, imported art/audio assets, or Android export preset were present in the inspected root tree.

## Consequence
The server subset is not sufficient to reconstruct the existing playable game or produce a trustworthy updated APK/AAB. Do not claim that a client build, control fix, map integration, or device test is complete until the full client project is restored and tested.

## Required source to resume
Restore the complete Godot client project, including:
- project.godot and all referenced .tscn/.tres/.gd files
- player, weapon, movement, aim, jetpack and UI scenes/scripts
- map scenes, collision geometry, sprites, fonts, sound and animation assets
- project settings and input map
- export_presets.cfg with secrets removed (do not share .godot/export_credentials.cfg or signing keys)

If the original ZIP cannot be uploaded in chat, use GitHub's web interface to add the complete project folders, or transfer the ZIP to a computer and push it to this repository. Do not upload signing keystores, passwords, API secrets, or private credentials.

## Next implementation order
1. Restore and open the complete client in the exact Godot version used by the project.
2. Run the project and record baseline errors.
3. Fix mobile movement/aim/fire/jetpack/reload controls.
4. Implement and test the Kerala-themed UI and first map.
5. Connect the client to the existing room server and test 2–6 clients.
6. Build debug APK for device testing; fix issues; then build signed release AAB.
7. Complete store assets and Data Safety only after actual SDK/data inventory.

## Honest completion rule
A feature is complete only when implemented in source and verified. A design document or server deployment is not proof of a playable Android client.

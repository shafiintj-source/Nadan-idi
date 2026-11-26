# Naadan Adi 3D — Architecture Decision Record

**Status:** Accepted for fresh prototype  
**Branch:** `fresh-3d-foundation`  
**Game:** 3D third-person arena shooter  
**Default language:** English; Malayalam selectable in Settings  
**Initial room size:** 2–6 players

## Product principles
- Original Kerala identity, original characters and environments.
- Mobile-first controls and readable combat.
- Fair progression: cosmetic rewards, no pay-to-win combat advantages.
- Start with one small playable arena; expand only after the core loop is reliable.

## Technology
- Client: Godot 4.x, GDScript, 3D renderer configured for mobile.
- First target: Android phones; desktop editor is required for authoring, testing and Android export.
- Multiplayer: retain the existing Render-hosted room server only after protocol compatibility is verified. Do not assume the old 2D/server protocol works with the new 3D client.
- Source control: GitHub. Keep signing keys, passwords and API secrets out of the repository.

## Camera and combat
- Third-person follow camera with shoulder/over-the-shoulder option considered after the prototype.
- CharacterBody3D movement, camera-relative locomotion, gravity and jump.
- Mobile input target: left virtual stick for movement; right drag region for camera/aim; dedicated fire, jump, reload and optional sprint buttons.
- Weapon aiming uses a ray or projectile from the camera centre with server-side hit validation in online play.
- Camera sensitivity, aim acceleration and dead-zone are configurable.

## First vertical slice
1. One greybox 3D arena with collision and spawn points.
2. One placeholder character with movement, jump and follow camera.
3. One test weapon and target dummies.
4. Touch UI and simultaneous movement + camera + fire testing on real Android devices.
5. Only then add art, animation, sound and networking.

## Kerala art direction
- UI: deep tropical teal, warm amber accents, clear English-first typography; Malayalam option.
- First environment: fictional Kerala hill-village arena inspired by Munnar tea slopes, monsoon greenery, tiled roofs and coconut palms. It should be an original fictional map, not a literal tourist-site replica.
- Later maps: Fort Kochi-inspired harbour and a fictional Thrissur festival-ground arena.
- Avoid real-person likenesses, unlicensed voices, logos and copyrighted characters.

## Multiplayer design
- 2–6 players, private room code, ready state, host start, match result and rematch.
- Server authoritative for room membership, health, damage, kills and match state.
- Client prediction/interpolation to be designed after offline movement is stable.
- Test 2, 4 and 6 clients, latency, packet loss, disconnect/reconnect and server restart.
- Do not expose a multiplayer toggle until end-to-end client/server tests pass.

## Quality gates
- Project opens in the pinned Godot version with no parse errors.
- Offline prototype works with keyboard/mouse in editor.
- Mobile touch controls work on real devices with simultaneous inputs.
- Stable frame rate on agreed low/mid-range Android devices.
- Online match is tested with multiple real clients.
- Privacy/Data Safety declarations match actual SDK and data collection.
- Signed AAB and release keystore are handled securely and never committed.

## Non-goals for the first prototype
- No battle pass, ads, in-app purchases, voice chat or public text chat.
- No multiple maps before one map and controls are fun and stable.

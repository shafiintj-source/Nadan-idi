# NAADAN ADI — Kerala Edition Game Design

## Product direction
A polished, original 2D side-view multiplayer arena shooter with a recognizably Kerala identity. The target is a fun, fair 2–6 player game, not a clone of another game's art or branding.

## Visual identity
- Dark tropical teal UI, warm monsoon amber highlights, clean readable typography.
- Malayalam-first interface with an English toggle.
- Original illustrated Kerala environments; no unlicensed celebrity likenesses, voices, logos, or copyrighted characters.
- High-contrast combat silhouettes and projectiles; scenery must never obscure players.

## Launch maps (scope-controlled)
1. **Munnar Mist** — tea slopes, mist, hillside paths and estate buildings.
2. **Fort Kochi Harbour** — waterfront, fishing nets, tiled roofs and dock platforms.
3. **Thrissur Festival Grounds** — festive lights and percussion-inspired atmosphere, without depicting dangerous crowd interactions.

Maps should be distinct gameplay spaces, not just background pictures. Each needs collision platforms, spawn points, cover, safe boundaries, and tested camera limits.

## Main menu
- Play: Quick Match / Create Private Room / Join with Code
- Practice: offline target range
- Loadout: weapons and cosmetic character skins
- Profile: level, match stats, achievements
- Settings: language, audio, control layout, sensitivity, aim dead-zone
- Room status and network connection indicators must be clear.

## Mobile controls (must be tested on real devices)
- Left thumb: movement joystick.
- Separate jump and jetpack buttons, with fuel indicator.
- Right thumb: 360-degree aim; fire while holding the fire control.
- Reload button and visible ammo count.
- Support simultaneous move + aim + fire + jetpack.
- Adjustable joystick size/position, sensitivity and dead-zone.
- Prevent UI controls from overlapping Android system gestures.
- Add a dedicated aim-training scene before public matchmaking.

## Multiplayer
- 2–6 players per room.
- Private room code, join, ready, host start, match result and rematch.
- Show reconnecting/disconnected states; never silently pretend a player is online.
- Server-authoritative validation for room membership and match state. Do not trust client claims for kills, score, or match completion.
- Test 2, 4 and 6 clients, latency, disconnect/reconnect, invalid room codes and server restart behaviour.

## Fair progression
- Cosmetic unlocks and achievements; no pay-to-win weapon stats.
- Match awards: best streak, comeback, team support and victory/defeat.
- Malayalam reaction captions are optional, rate-limited and individually muteable.
- Rematch is an invitation, not pressure; show ready count and allow players to leave.

## Accessibility and quality
- Malayalam and English text must fit small screens.
- Separate music, effects and voice volume.
- Colour/shape cues must supplement colour-only status.
- Low-end Android performance mode and scalable effects.
- Privacy notice, reporting/mute controls if public chat is added.

## Release gates
- Full client project and assets exist in version control.
- Controls pass real-device testing.
- Core offline match loop works.
- Online rooms pass multi-client tests.
- No crash/blocker defects in supported devices.
- Privacy/Data Safety declarations match actual SDK and data behaviour.
- Signed AAB is built with a securely stored signing key; never commit passwords or keystore files.

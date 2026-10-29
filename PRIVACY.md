# Naadan Adi Privacy Policy
Updated: 30 October 2026

Naadan Adi (package `club.fiction.naadanadi`) is a Kerala-themed game from FICTION CLUB. Contact: **mail@fictionclub.in**.

This policy describes the current v0.6 playtest and its room-server implementation. It must be reviewed if the release adds advertising, analytics, accounts or other services.

## Information used to play
Offline practice runs on your device. The game saves preferences such as outfit, weapon, reaction settings and the selected server address locally.

When you join a multiplayer room, your selected player nickname, room membership, ready status, gameplay inputs and match state are transmitted so the match can operate. Match state includes positions, health and scores. Other players in that room can see your nickname and relevant match state. Use a nickname rather than sensitive personal information.

The online server assigns temporary player identifiers and a reconnect token. The token is used to reconnect your session; it is not intentionally included in application logs. Networking and hosting systems necessarily handle connection information, such as IP addresses. The application does not use IP addresses to provide a location feature.

## Hosting and logs
The official online room service is hosted by Render. Hosting infrastructure processes connection and operational information to deliver the service. Application logs contain events such as room creation, round starts and reconnects, including room codes and temporary player numbers. The game does not contain a permanent player-account database.

Room state is held in server memory. Rooms expire after approximately 30 minutes or disappear when all players leave; server restarts also clear rooms. Disconnected player slots are temporarily reserved for reconnecting. Operational logs have a separate hosting-provider retention lifecycle and are not covered by the room-expiry period.

Provider information: https://render.com/privacy

## Local networks and transport
The official online endpoint uses encrypted WSS transport. The playtest also supports plain WebSocket addresses and direct local-network play. These local or custom connection modes do not provide the same transport-encryption guarantee. Only connect to servers and local networks you trust. A custom server is operated by its owner and may have different data practices.

## Audio and device services
The game does not record your voice. Optional spoken reactions use an installed device text-to-speech service where available. That service may use local or network processing according to your device settings and the provider's practices. Reaction text is predefined game content, not microphone input.

## Advertising, accounts and purchases
The current playtest has no advertising SDK, in-app purchases, persistent account registration or Firebase integration. We do not sell gameplay information or use this game for targeted advertising.

## Your choices and requests
You can use offline practice without joining an online room, leave a room, and disable reactions. Uninstalling the app or clearing its application storage removes locally saved settings. For privacy questions or deletion requests, contact mail@fictionclub.in. Do not send passwords or reconnect tokens. Include only the information needed to identify your request; operational records may be subject to provider retention and security requirements.

If you contact us by email, your address and message are used to respond to your request. Your email provider and ours process that correspondence.

## Children
The game is not designed to collect sensitive information from children. A parent or guardian with a privacy concern can contact us at the address above. The Google Play age rating and target audience must be set separately based on the released content.

## Changes
We will update this page when material data practices change. The policy date above identifies this version.

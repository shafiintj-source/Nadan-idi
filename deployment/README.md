# Private room server — v0.4 alpha

The server runs the same authoritative simulation as the game. It supports 20 concurrent rooms, each with 2–6 players. This cap is a guardrail, not a measured hosting capacity. No public service has been deployed.

## Local server
Use Godot 4.3 for Linux/Windows:

    godot --headless --path . --script res://server/main.gd

From this project's root with Docker installed:

    docker build -t naadan-adi-server .
    docker run --rm -p 8787:8787 naadan-adi-server

The Docker recipe has not been built in this environment. The actual headless server executable was tested locally. On the same PC use ws://127.0.0.1:8787 in ONLINE / PRIVATE ROOMS. Phones must use the server PC's LAN IPv4 address, for example ws://192.168.1.10:8787. Allow TCP 8787 on the private network. This is a separate option from the game's direct UDP LAN HOST/JOIN.

## Public hosting
Deploy the Dockerfile from the project root to an x86-64 Linux service supporting persistent WebSockets. Bind its PORT environment variable (default 8787). The platform must terminate HTTPS/WSS and forward WebSocket upgrade connections to the container. Use a TCP health check; the game server does not serve an HTTP health page. Keep one instance: room state is in memory, with no cross-instance routing or database. Restarts erase rooms. Choose capacity and hosting charges before launching a service; no paid service was created by this project.

Enter the resulting wss:// address in every player's game. CREATE ROOM gives a six-character code; friends use the same address and code to JOIN. Everyone taps READY, then the host taps START. Results return to the lobby; ready again to rematch. The room lasts 30 minutes. A brief disconnect reserves your slot for 20 seconds; the client retries for up to 18 seconds after detecting loss. A long OS suspension or delayed loss detection may require joining again.

For internet use, use WSS so room/session credentials travel over TLS. Session tokens stay in client memory and are not logged. Rooms are private-by-code, not accounts or access-controlled invitations. The alpha includes message-size/rate limits and server-owned damage/input, but has no production abuse monitoring, DDoS protection or regional latency service. Real internet latency and load remain untested.

## Render handoff
Render was connected and Shafi's workspace selected for this project. No service was created. GitHub publishing was deferred at the user's request. The included render.yaml uses a free single-instance Singapore service for an initial trial, with automatic deploys disabled. It passed the current public JSON schema; it has not been validated by the Render CLI or deployed. Free compute is a trial choice, not a performance promise. Push this project as the repository root before using the Blueprint; review the free service limits before use.

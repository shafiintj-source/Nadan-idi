# Naadan Adi — private room server

Godot 4.3 authoritative WebSocket server for the Android v0.6 playtest.

## Playtest connection

Server: `wss://naadan-adi-rooms.onrender.com`

In the APK open ONLINE, paste this address, and select CREATE A PRIVATE ROOM. Friends enter the same address and six-character room code, then JOIN ROOM. Everyone selects READY; the host selects START. The v0.6 APK's initial hosting-pending label predates deployment; entering the address enables connection.

## Deployment and verification

Deployed on 2026-10-28 to Render Free, Singapore, one instance. Service `srv-dbgsg78ae00c73daafo0`; deploy `dep-dbgsg80ae00c73daah9g` reached live using commit `db2a2bee166c94d4fb73d04349f4fb5dbb989d79`.

A public WSS protocol smoke test passed: six clients created/joined a room, readied, started, and received six-actor state with advancing simulation ticks. This is not a real-device gameplay, latency, or capacity benchmark. Android hardware testing is still needed.

## Limits

Rooms last 30 minutes and contain 2–6 players. State is in memory; restarts erase rooms. Automatic deploys are disabled. Keep one instance. The server accepts WebSockets, not ordinary web pages; HTTP probes can produce WebSocket handshake log errors. Free hosting is for testing, not a production performance guarantee.

## Local execution

`docker build -t naadan-adi-server .`

`docker run --rm -p 8787:8787 naadan-adi-server`

Local endpoint: `ws://127.0.0.1:8787`. Public connections must use WSS.

This repository contains the server subset; no Android signing keys are included.

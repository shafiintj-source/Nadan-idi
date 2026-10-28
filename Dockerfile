FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl unzip libfontconfig1 libx11-6 libxcursor1 libxinerama1 libgl1 libxi6 libxrandr2 libasound2 libpulse0 && rm -rf /var/lib/apt/lists/*
RUN curl -fsSL https://github.com/godotengine/godot-builds/releases/download/4.3-stable/Godot_v4.3-stable_linux.x86_64.zip -o /tmp/godot.zip \
 && echo '7de56444b130b10af84d19c7e0cf63cf9e9937ee4ba94364c3b7dd114253ca21  /tmp/godot.zip' | sha256sum -c - \
 && unzip /tmp/godot.zip -d /tmp \
 && mv /tmp/Godot_v4.3-stable_linux.x86_64 /usr/local/bin/godot \
 && rm /tmp/godot.zip && useradd -m game
WORKDIR /app
COPY deployment/server-project.godot ./project.godot
COPY server ./server
COPY scripts/match.gd scripts/wire.gd ./scripts/
USER game
ENV PORT=8787
EXPOSE 8787
CMD ["godot", "--headless", "--path", "/app", "--script", "res://server/main.gd"]

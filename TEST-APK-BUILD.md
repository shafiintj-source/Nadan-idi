# Naadan Adi — Test APK build

This branch is deliberately separate from the existing app and from the original 3D foundation branch.

- Branch: `test-apk-2026-11-25`
- Android test package: `club.fiction.naadanadi.test`
- Build type: debug APK, ARM64
- Export target: `build/NaadanAdi-Test.apk`
- Build trigger: push to this branch or manually run the GitHub Actions workflow.
- Download: GitHub repository → Actions → latest “Build Naadan Adi Android Test APK” run → Artifacts → `NaadanAdi-Test-APK`.

The test package ID is intentionally different from the production package ID so this test build can be installed side-by-side rather than overwriting the existing app.

This is a fresh Godot 4 3D prototype, not a repair or replacement of the installed APK. The project still requires Godot runtime validation and on-device touch/performance testing. Do not publish this debug APK to Play Store.

No signing keystore, passwords, API keys or credentials belong in this branch.

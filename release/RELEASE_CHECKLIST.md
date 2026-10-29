# Naadan Adi — Play release checklist
Status: **PREPARATION ONLY — NOT READY TO UPLOAD**
Updated: 30 October 2026

## Completed
- [x] Server source is in GitHub.
- [x] Render deployed the server on 28 October 2026.
- [x] Six-client public WSS smoke test passed on that date.
- [x] Package ID file and English/Malayalam store-copy drafts added.
- [x] Current-playtest privacy policy published in this repository.
- [x] Data-handling review worksheet added (NOT a Play import CSV).

## Build and signing
- [ ] Restore the full client source ZIP; this repository currently contains the server subset and release documents, not the full Android project.
- [ ] Restore an operational Android build workspace.
- [ ] Upgrade Android export tooling for API 36; the v0.6 test APK targets API 34.
- [ ] Verify all native libraries against the current 16 KB page-size requirements.
- [ ] If this package already has a Play release, obtain its existing upload key or use Google's upload-key reset process. Do not replace an existing app signing identity.
- [ ] For a first Play release, generate a dedicated upload key using a cryptographically secure tool.
- [ ] Store keystore and password separately and privately. Never commit them to this public repository.
- [ ] Export a signed release AAB; ensure it is not debuggable.
- [ ] Validate bundle structure, package ID, version code, target SDK and signing certificate.
- [ ] Generate installable APKs from the AAB and test them.
- [ ] Save a private full delivery ZIP including the signing backup; make a separate public ZIP without secrets.

## App changes still required
- [ ] Embed the official WSS endpoint in the release.
- [ ] Remove obsolete hosting-pending labels.
- [ ] Add a visible privacy-policy link in the app.
- [ ] Audit plain WS/LAN transport before completing the encryption declaration.
- [ ] Add a neutral Play review flow only after sufficient play, independent of wins or losses.
- [ ] Add separate Help/Feedback access for all players.
- [ ] Test first launch, offline practice, six-player online room, full match, rematch, reconnect and server cold start.
- [ ] Test Android phone, 7-inch and 10-inch tablet layouts; safe areas; touch controls; background/resume; back navigation.
- [ ] Check crashes, freezes, sound controls, battery and memory use on real devices.
- [ ] Re-run regression tests after engine/toolchain changes.

## Graphics
- [ ] Capture REAL gameplay from the final build. Do not invent screenshots.
- [ ] Prepare at least three 1920×1080 landscape phone screenshots; tablet screenshots must reflect tested tablet layouts.
- [ ] Add short upper captions; keep gameplay prominent and captions within about 20% of the image.
- [ ] Make requested unbranded device-frame marketing versions separately. Google recommends avoiding device imagery in store screenshots; retain clean gameplay versions.
- [ ] Export a 1024×500 feature graphic, JPEG or 24-bit PNG without alpha.
- [ ] Export the 512×512 Play icon and matching adaptive app icon.
- [ ] Review contrast, spelling, image dimensions and previews at small sizes.
- [ ] Do not include fake rankings, stars, testimonials or unsupported features.

## Play Console — tick in order
- [ ] Create/select the app under the intended developer account.
- [ ] Confirm app name, package, language, game category and distribution settings.
- [ ] Set the real support email and privacy-policy URL.
- [ ] Upload the release AAB to internal testing.
- [ ] Review automated pre-launch results and manually test Play-delivered installs.
- [ ] Complete App access, Ads, Content rating and Target audience using actual behavior.
- [ ] Complete Data safety using the final AAB and server/provider audit.
- [ ] Export or download the official Data safety CSV, fill it and verify import in Play Console. The included worksheet is not importable.
- [ ] Add verified store text, icon, feature graphic and phone/tablet screenshots.
- [ ] Complete any testing and production-access requirements shown for this account.
- [ ] Resolve policy and technical warnings.
- [ ] Submit for review only after all blockers are resolved. Approval and zero bugs cannot be guaranteed.

## Mac Desktop
An assistant cannot place files on the Mac without a connected, authorized filesystem.
In Finder: Desktop → create “FICTION CLUB” → create “Naadan Adi”.
Download and extract the final delivery ZIP there when available.
Keep the private signing backup outside any public GitHub-synced directory.

## Links
- Privacy policy: https://github.com/shafiintj-source/Nadan-idi/blob/main/PRIVACY.md
- API requirements: https://support.google.com/googleplay/android-developer/answer/11926878
- Data safety: https://support.google.com/googleplay/android-developer/answer/10787469
- Preview assets: https://support.google.com/googleplay/android-developer/answer/9866151
- Review API: https://developer.android.com/guide/playcore/in-app-review

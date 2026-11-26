# Naadan Adi HD — Touch, Map and Customization UX

## Design principles
- No dropdown-based primary selection for guns, skins, outfits or maps.
- Use large visual cards in a horizontal carousel or 2-column grid, with a clear selected state and one-tap Equip button.
- Show weapon silhouette, name, owned/locked state and useful stats on each card. Keep stats compact; compare damage, fire rate, range and handling.
- Separate tabs for Weapons, Skins, Character and Maps. Use horizontal category chips, not nested dropdown menus.
- Do not display an Equip button as functional until selection is saved and reflected in the live character/loadout.
- Provide a clear Back button and preserve the previous tab/scroll position.

## Recommended mobile controls
- Left lower area: floating movement joystick with a generous dead zone and adjustable size/position.
- Right half: camera/aim drag area; avoid placing small controls in the center aiming zone.
- Right lower corner: large Fire button, with Jump above/near it and Reload nearby but separated to reduce accidental taps.
- Add a compact weapon-switch button and optional Sprint control only after the base layout is comfortable.
- Support simultaneous joystick movement, camera drag and fire; this is a required device test.
- Settings should allow sensitivity, button opacity, button size and left/right-handed layout.
- Keep HP and ammo at the top corners, with a simple center crosshair.
- All touch actions must have desktop keyboard/mouse equivalents for editor testing.

## Map layout principles
- Larger playable area must still have readable combat lanes; avoid a huge empty field.
- Every combat zone needs multiple routes, cover, flanking paths and recognizable landmarks.
- Use safe spawn zones separated from immediate line-of-sight fire.
- Add soft visual boundaries such as hills, tree lines, walls and water channels, plus collision boundaries.
- Optimize props and visibility for Android; avoid dense expensive foliage and unnecessary real-time shadows.

## Current greybox change
- First arena floor expanded from 40 x 40 to 120 x 120 world units.
- Player spawn moved to the south side; training target moved farther north.
- Added perimeter walls, four house-like structures, cover lanes, palms and distant green hills.
- This is functional-layout greybox geometry, not final art or a verified finished map.

## Acceptance checks
- A player can move around the larger arena without falling out of bounds.
- Multiple routes connect spawn, central cover and target zones.
- No cover blocks the only route or traps the player.
- Fire, aim, movement and jump work together on a real Android phone.
- Gun/skin/map selection is one tap from visible cards; no dropdown is needed.
- Selected loadout persists after leaving and returning to the screen.
- Performance remains stable on a representative mid-range Android device.
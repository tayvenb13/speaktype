# Harden SpeakType for offline/private local use + default hotkey ⌘2

## Goal
Remove all network-facing behavior tied to monetization/updates, keep transcription
fully local, fix local data-retention/logging/file-handling privacy issues, reduce
entitlements, and change the default dictation hotkey from Fn to Command+2.

## Changes

### 1. License / Polar removal
- Delete `LicenseManager.swift`, `LicenseManager+Extensions.swift`, `KeychainHelper.swift`,
  `TrialManager.swift`, `LicenseView.swift`, `ProFeatureGate.swift`, `TrialBanner.swift`.
- Remove `licenseManager`/`trialManager` from `speaktypeApp`, `SettingsView`, `DashboardView`.
- `ClipboardService`: drop the licenseManager dependency + promo-wrapper.
- One-time best-effort Keychain purge of the old `sh.polar.speaktype.license` item in AppDelegate.

### 2. GitHub update removal
- Delete `UpdateService.swift`, `UpdateSheet.swift`.
- AppDelegate: remove launch update check + update-window plumbing.
- SettingsView: remove the Updates section + `autoUpdate`.
- `AppVersion.swift`: strip GitHub release decoding/install model; keep version display statics.

### 3. Offline transcription
- Model download stays user-initiated only (no auto-download — already true).
- AIModelsView: add copy that downloading a model contacts the model host (Hugging Face)
  over the network and that transcription is local afterward.
- README: document offline-after-install.

### 4. Data retention
- `HistoryService.clearAll()` deletes associated audio files too.
- Clear-All confirmation copy says transcripts AND saved audio are removed.

### 5. Sensitive logging
- Remove `/tmp/speaktype_debug.log` (MiniRecorderView.debugLog → os.Logger, no file).
- Remove transcript snippets / clipboard contents / full recording paths from logs.

### 6. File handling
- Imported audio/video copied to app-owned Application Support/SpeakType/Recordings
  with UUID filenames (TranscribeAudioView + DashboardView).

### 7. Entitlements
- Remove `com.apple.security.automation.apple-events` (AppleScript paste fallback removed).
- Remove dead `com.apple.security.assets.music.read-write`.
- Keep `device.audio-input`, `files.user-selected.read-write`, `network.client`
  (network.client is required: WhisperKit downloads models from Hugging Face).
- Sandbox stays OFF — global CGEvent tap + synthetic paste require non-sandboxed Accessibility.

### 8. Release hygiene
- Generate + commit `Package.resolved`.

### 9. Hotkey → ⌘2
- `HotkeyOption`: add `.commandTwo` (keyCode 19, .command), `isModifierOnly`, `cgModifierFlag`;
  default = `.commandTwo`.
- AppDelegate: combo handled via the CGEvent tap (keyDown/keyUp) so the combo is suppressed
  from the focused app; modifier-only path unchanged. Hold + toggle both supported.
- Update default in SettingsView and `getSelectedHotkey()` fallback; preserve user-chosen hotkeys.
- Update onboarding + empty-state copy (Fn/Globe/⌘+Shift+Space → ⌘2).

## Validation
Build with xcodebuild, run tests, grep for api.github.com / polar.sh / URLSession /
NSAppleScript / /tmp/speaktype_debug.log / transcript+clipboard log patterns.

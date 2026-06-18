# speaktype-tb

<div align="center">

![speaktype-tb Icon](speaktype/Assets.xcassets/AppIcon.appiconset/icon_256x256.png)

**Fast, Offline, Private Voice-to-Text for macOS**

![speaktype-tb app screenshot](image.png)
[![Download](https://img.shields.io/badge/Download-speaktype--tb.dmg-blueviolet?logo=apple&logoColor=white)](https://github.com/tayvenb13/speaktype/releases/latest)
[![Swift](https://img.shields.io/badge/Swift-5.9-orange?logo=swift)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-macOS%2013.0+-blue?logo=apple)](https://www.apple.com/macos/)
[![License](https://img.shields.io/badge/License-MIT-red)](LICENSE)

*Press a hotkey, speak, and instantly paste text anywhere on your Mac.*

</div>

---

## What is speaktype-tb?

`speaktype-tb` is a privacy-hardened fork of [SpeakType](https://github.com/karansinghgit/speaktype) — an **offline voice dictation tool** for macOS where everything runs **100% locally** using OpenAI's Whisper model via [WhisperKit](https://github.com/argmaxinc/WhisperKit).

This fork strips out everything that touches the network for non-transcription reasons: no license/activation server, no telemetry, and no auto-update checks. The **only** network access is the explicit, user-initiated model download (see [Privacy & Networking](#privacy--networking)).

- **Private** - Audio and transcripts never leave your Mac
- **Offline** - No account, no license check, no update pings
- **Fast** - Optimized for Apple Silicon
- **Works Everywhere** - Any app, any text field
- **Open Source** - Audit every line of code yourself

---

## Installation

### Requirements

- macOS 13.0+ (Ventura or newer)
- Apple Silicon (M1+) recommended
- 2GB available storage (for AI models)

### Download

**[Download Latest Release](https://github.com/tayvenb13/speaktype/releases/latest)**

1. Download `speaktype-tb.dmg` and open it
2. Drag **speaktype-tb** to **Applications**
3. First launch: right-click the app → **Open** (the release is ad-hoc signed, not notarized)
4. Grant Microphone + Accessibility + Documents Folder permissions
5. Download an AI model from Settings → AI Models

Press `⌘2` to start dictating.

> Releases are built and published automatically by the
> [Build & Release workflow](.github/workflows/build-release.yml) whenever a `v*` tag is pushed.

### Build from Source

```bash
git clone https://github.com/tayvenb13/speaktype.git
cd speaktype

# Build a Release app (ad-hoc signed) into a local folder:
xcodebuild build -scheme speaktype -configuration Release \
  -destination 'platform=macOS' \
  CONFIGURATION_BUILD_DIR=build \
  CODE_SIGN_IDENTITY="-" CODE_SIGN_STYLE=Manual DEVELOPMENT_TEAM="" \
  CODE_SIGNING_REQUIRED=YES CODE_SIGNING_ALLOWED=YES

open build   # build/speaktype-tb.app
```

---

## Usage

1. Press hotkey (`⌘2` by default)
2. Speak your text
3. Release hotkey
4. Text appears!

Change the shortcut or switch between **Hold** and **Toggle** modes under Settings → Shortcuts.

**Tips:**
- Speak naturally - Whisper handles accents well
- Say punctuation: "comma", "period", "question mark"
- Best results with 3-10 second clips

---

## Privacy & Networking

speaktype-tb is built for fully local, offline use:

- **Transcription is 100% local.** Audio and transcripts never leave your Mac. There is no
  account, license check, telemetry, or update check.
- **The only network access is model download.** When you explicitly download a model from
  Settings → AI Models, the app contacts the model host (Hugging Face). This is the single
  reason the `com.apple.security.network.client` entitlement is retained. Models are **never
  downloaded automatically** — it is always an explicit user action. After a model is
  installed, dictation works offline.
- **Local data retention.** Recordings and imported files are stored under
  `~/Library/Application Support/speaktype-tb/Recordings` with random (UUID) filenames.
  "Clear All" in History permanently deletes both the transcripts and their saved audio.

> Note: the app is **not** App-Sandboxed. A global hotkey event tap and synthetic paste both
> require Accessibility access, which the macOS App Sandbox does not permit. Microphone,
> user-selected file access, and model-download network access are the only entitlements.

---

## Development

```bash
make build          # Build debug
make run            # Run app
make clean          # Clean build
make test           # Run tests
make dmg            # Create DMG installer
```

### Current Issues

⚠️ When loading a model for the first time / switching to another model, there is a startup delay of 30-60 seconds. 

So the first transcription will appear ultra slow, but it will go back to instantaneous dictation right after it's warmed up. 

### Project Structure

```
speaktype/
├── App/           # Entry point
├── Views/         # SwiftUI interface
├── Models/        # Data models
├── Services/      # Core functionality
├── Controllers/   # Window management
└── Resources/     # Assets & config
```

### Tech Stack

- **Swift 5.9+** / SwiftUI + AppKit
- **[WhisperKit](https://github.com/argmaxinc/WhisperKit)** - Local Whisper inference
- **[KeyboardShortcuts](https://github.com/sindresorhus/KeyboardShortcuts)** - Global hotkeys
- **AVFoundation** - Audio capture

---

## Contributing

1. Fork & clone
2. Create a branch: `git checkout -b feature/my-feature`
3. Make changes and run `make lint`
4. Submit a PR

---

## License

MIT License - see [LICENSE](LICENSE) for details.

---

## Credits

- [WhisperKit](https://github.com/argmaxinc/WhisperKit) by Argmax
- [OpenAI Whisper](https://github.com/openai/whisper)

---

<div align="center">

**Made with ❤️ for developers**

*Privacy-first • Open Source *

</div>

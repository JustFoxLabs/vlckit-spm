# VLCKitSPM

Swift Package distribution of the VLCKit (libVLC) build used by the [FoxIPTV](https://foxiptv.app)
apps by JustFox Labs.

This package vends a **modified build of VLCKit `4.0.0-alpha.20`** as a binary `VLCKit.xcframework`
(**iOS + tvOS**, device + simulator). The modifications fix crashes that occur on rapid live-TV
channel switching with the upstream `alpha.20` build.

## Usage

```swift
.package(url: "https://github.com/JustFoxLabs/vlckit-spm", exact: "4.0.0-alpha.20-fox.5")
```

Then add `VLCKitSPM` as a dependency of your target.

## License & modified source (LGPL-2.1-or-later)

VLCKit and libVLC are licensed under the **GNU Lesser General Public License, version 2.1 or
later**. The binary in this package is a **modified** build. In accordance with the LGPL, the
complete corresponding modified source is publicly available:

- **VLCKit:** https://code.videolan.org/JustFox/VLCKit/-/tree/de66f6da4508d601bf7a2322f4ec6434cd8c17e3
- **libVLC:** https://code.videolan.org/JustFox/vlc/-/tree/fcbaa21a99c9e2f23aa58e33d1109b3a0a3a1302

The binary is built from those exact (immutable) commits. It corresponds to upstream libVLC commit
`fe6e76a90` plus the patch series `libvlc/patches/0001-0025` applied by VLCKit's
`compileAndBuildVLCKit.sh` (0025 is the `lib/media_player.c` rapid-zap use-after-free fix),
together with the `VLCMediaPlayer` meta-changed teardown fix. Both the iOS and tvOS slices are
built from this same source.

`VLCKit.framework` is a **dynamic** framework, so the library remains replaceable, satisfying the
LGPL relink requirement.

See `LICENSE` for the full license notice.

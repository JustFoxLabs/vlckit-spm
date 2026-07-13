# VLCKitSPM

Swift Package distribution of the VLCKit (libVLC) build used by the [FoxIPTV](https://foxiptv.app)
apps by JustFox Labs.

This package vends a **modified build of VLCKit `4.0.0-alpha.20`** as a binary `VLCKit.xcframework`
(iOS device + simulator). The modifications fix crashes that occur on rapid live-TV channel
switching with the upstream `alpha.20` build.

## Usage

```swift
.package(url: "https://github.com/JustFoxLabs/vlckit-spm", exact: "4.0.0-alpha.20-fox.4")
```

Then add `VLCKitSPM` as a dependency of your target.

## License & modified source (LGPL-2.1-or-later)

VLCKit and libVLC are licensed under the **GNU Lesser General Public License, version 2.1 or
later**. The binary in this package is a **modified** build. In accordance with the LGPL, the
complete corresponding modified source is publicly available:

- **VLCKit:** https://code.videolan.org/JustFox/VLCKit/-/tree/foxiptv-2.0.1
- **libVLC:** https://code.videolan.org/JustFox/vlc/-/tree/foxiptv-2.0.1

The binary is built from those exact tags. It corresponds to upstream libVLC commit
`fe6e76a90` plus the patch series `libvlc/patches/0001-0024` applied by VLCKit's
`compileAndBuildVLCKit.sh`, together with the `VLCMediaPlayer` meta-changed teardown fix.

`VLCKit.framework` is a **dynamic** framework, so the library remains replaceable, satisfying the
LGPL relink requirement.

See `LICENSE` for the full license notice.

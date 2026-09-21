# VLCKitSPM

Swift Package distribution of the VLCKit (libVLC) build used by the [FoxIPTV](https://foxiptv.app)
apps by JustFox Labs.

This package vends a **modified build of VLCKit `4.0.0-a24`** as a binary `VLCKit.xcframework`
(**iOS + tvOS**, device + simulator). The modifications fix crashes that occur on rapid live-TV
channel switching and during Picture-in-Picture teardown.

**Minimum deployment target is 15.0** for both platforms (it was 13 in the `alpha.20` releases).
Xcode 27 declines to archive anything below 15.0, so the binary requires it.

## Usage

Add the package to your `Package.swift` dependencies:

```swift
.package(url: "https://github.com/JustFoxLabs/vlckit-spm", exact: "4.0.0-alpha.24-fox.1")
```

Then add the `VLCKitSPM` product to the target that needs it:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "VLCKitSPM", package: "vlckit-spm")
    ]
)
```

In Xcode instead: **File > Add Package Dependencies…**, enter the URL above, pin the exact
version, and add the `VLCKitSPM` library to your app target.

Then import the module in source:

```swift
import VLCKitSPM
```

## License & modified source (LGPL-2.1-or-later)

VLCKit and libVLC are licensed under the **GNU Lesser General Public License, version 2.1 or
later**. The binary in this package is a **modified** build. In accordance with the LGPL, the
complete corresponding modified source is publicly available:

- **VLCKit:** https://code.videolan.org/JustFox/VLCKit/-/tree/827ebdda348548a956ec4d9c22b2169457720219
- **libVLC:** https://code.videolan.org/JustFox/vlc/-/tree/52e28931920cc5dc3ba2d1a9774e30aa06f7a9a3

The binary is built from those exact (immutable) commits. It corresponds to upstream libVLC commit
`5dd4aebda` (VLCKit `4.0.0-a24`'s pinned `TESTEDHASH`) plus the patch series
`libvlc/patches/0001-0020` applied by VLCKit's `compileAndBuildVLCKit.sh`, together with the
`VLCMediaPlayer` teardown fixes in the VLCKit Objective-C layer. Both the iOS and tvOS slices are
built from this same source.

Of those twenty patches, `0001`-`0017` are upstream VLCKit's own series, carried unchanged. The
three JustFox patches are:

- `0018` `access/http`: initialise the authentication structures before any error path in `Open()`
- `0019` `video_output/apple`: fix a use-after-free in the Picture-in-Picture delegate on teardown
- `0020` `extras/package/apple`: define `NDEBUG`

`NDEBUG` matters because libVLC's internal `assert()`s would otherwise ship active and `abort()` on
edge-case streams. `configure.ac` does define `NDEBUG` under `--disable-debug`, but neither this
build recipe nor upstream's own release CI passes that flag, so the define is applied directly to
the compiler flags instead.

`VLCKit.framework` is a **dynamic** framework, so the library remains replaceable, satisfying the
LGPL relink requirement.

See `LICENSE` for the full license notice.

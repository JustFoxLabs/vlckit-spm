// swift-tools-version: 5.9
import PackageDescription

// VLCKitSPM - Swift Package distribution of the VLCKit (libVLC) build used by the JustFox
// apps (FoxIPTV). This is a MODIFIED build of VLCKit 4.0.0-a24; see README.md for the
// LGPL notice and the corresponding modified source.
//
// fox.1 on the a24 base vends iOS + tvOS slices (device + simulator). It carries three libVLC
// patches on top of upstream's own series - HTTP auth-struct initialisation, a Picture-in-Picture
// delegate use-after-free fix, and -DNDEBUG so libVLC's internal assert()s compile out instead of
// abort()-ing on edge-case streams - plus teardown guards in the VLCKit Objective-C layer.
//
// Minimum OS is 15.0 for both platforms, up from 13 in the alpha.20 releases. Xcode 27 refuses to
// archive below 15.0 (its supported range is 15.0 to 27.0.x), so the binary genuinely requires it -
// verified with vtool: minos 15.0, sdk 27.0 on every slice.
//
// Rebased from the alpha.20 base: upstream absorbed the simulator dup3/pipe2 build fix and the
// rapid-zap media_player use-after-free, so the local patch count drops from eight to three.
//
// Modified source (LGPL-2.1-or-later):
//   VLCKit: https://code.videolan.org/JustFox/VLCKit/-/tree/827ebdda348548a956ec4d9c22b2169457720219
//   libVLC: https://code.videolan.org/JustFox/vlc/-/tree/52e28931920cc5dc3ba2d1a9774e30aa06f7a9a3

let vlcBinary = Target.binaryTarget(
    name: "VLCKit",
    url: "https://github.com/JustFoxLabs/vlckit-spm/releases/download/4.0.0-alpha.24-fox.1/VLCKit.xcframework.zip",
    checksum: "f37b741c46f452993d1f3411e52d2dc2a60ab164ebf3244ed0190fdfd7d74aa6"
)

let package = Package(
    name: "VLCKitSPM",
    platforms: [
        .iOS(.v15),
        .tvOS(.v15)
    ],
    products: [
        .library(name: "VLCKitSPM", targets: ["VLCKitSPM"])
    ],
    dependencies: [],
    targets: [
        vlcBinary,
        .target(
            name: "VLCKitSPM",
            dependencies: [.target(name: "VLCKit")],
            linkerSettings: [
                .linkedFramework("QuartzCore", .when(platforms: [.iOS])),
                .linkedFramework("CoreText", .when(platforms: [.iOS, .tvOS])),
                .linkedFramework("AVFoundation", .when(platforms: [.iOS, .tvOS])),
                .linkedFramework("Security", .when(platforms: [.iOS])),
                .linkedFramework("CFNetwork", .when(platforms: [.iOS])),
                .linkedFramework("AudioToolbox", .when(platforms: [.iOS, .tvOS])),
                .linkedFramework("OpenGLES", .when(platforms: [.iOS, .tvOS])),
                .linkedFramework("CoreGraphics", .when(platforms: [.iOS])),
                .linkedFramework("VideoToolbox", .when(platforms: [.iOS, .tvOS])),
                .linkedFramework("CoreMedia", .when(platforms: [.iOS, .tvOS])),
                .linkedLibrary("c++", .when(platforms: [.iOS, .tvOS])),
                .linkedLibrary("xml2", .when(platforms: [.iOS, .tvOS])),
                .linkedLibrary("z", .when(platforms: [.iOS, .tvOS])),
                .linkedLibrary("bz2", .when(platforms: [.iOS, .tvOS])),
                .linkedLibrary("iconv")
            ]
        )
    ]
)

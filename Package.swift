// swift-tools-version: 5.9
import PackageDescription

// VLCKitSPM - Swift Package distribution of the VLCKit (libVLC) build used by the JustFox
// apps (FoxIPTV). This is a MODIFIED build of VLCKit 4.0.0-alpha.20; see README.md for the
// LGPL notice and the corresponding modified source.
//
// fox.6 vends iOS + tvOS slices (device + simulator), with libVLC patches 0001-0025 (incl. the
// media_player rapid-zap use-after-free fix). fox.6 rebuilds both platforms with NDEBUG defined
// (release), so libVLC's internal assert()s compile out and degrade gracefully instead of
// abort()-ing on edge-case streams (e.g. an adaptive-HLS segment-list assert on a live playlist
// with a sequence gap + zero segment duration). This is a build-flag change over fox.5 (same
// patch series), so the slices are freshly built with asserts off.
//
// Modified source (LGPL-2.1-or-later):
//   VLCKit: https://code.videolan.org/JustFox/VLCKit/-/tree/de66f6da4508d601bf7a2322f4ec6434cd8c17e3
//   libVLC: https://code.videolan.org/JustFox/vlc/-/tree/7eb40de9123b223a871e7b620c3516f40a4121de

let vlcBinary = Target.binaryTarget(
    name: "VLCKit",
    url: "https://github.com/JustFoxLabs/vlckit-spm/releases/download/4.0.0-alpha.20-fox.6/VLCKit.xcframework.zip",
    checksum: "678bab7c9b6f13e19f98e89de426cddcf1c834b245d735bc269aabe18c6a2514"
)

let package = Package(
    name: "VLCKitSPM",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13)
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

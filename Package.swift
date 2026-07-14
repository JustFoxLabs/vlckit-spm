// swift-tools-version: 5.9
import PackageDescription

// VLCKitSPM - Swift Package distribution of the VLCKit (libVLC) build used by the JustFox
// apps (FoxIPTV). This is a MODIFIED build of VLCKit 4.0.0-alpha.20; see README.md for the
// LGPL notice and the corresponding modified source.
//
// fox.5 vends iOS + tvOS slices (device + simulator), with libVLC patches 0001-0025 (the
// 0025 media_player rapid-zap use-after-free fix included). The iOS slices are identical
// to fox.4 (already shipping in the FoxIPTV iOS app); fox.5 adds the tvOS slices.
//
// Modified source (LGPL-2.1-or-later):
//   VLCKit: https://code.videolan.org/JustFox/VLCKit/-/tree/foxiptv-2.0.1
//   libVLC: https://code.videolan.org/JustFox/vlc/-/tree/foxiptv-2.0.1

let vlcBinary = Target.binaryTarget(
    name: "VLCKit",
    url: "https://github.com/JustFoxLabs/vlckit-spm/releases/download/4.0.0-alpha.20-fox.5/VLCKit.xcframework.zip",
    checksum: "473ff695e0bed14836adcb621b630b431220bea2d43da9df10a38e0aac44d02d"
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

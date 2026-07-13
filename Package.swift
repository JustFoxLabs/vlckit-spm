// swift-tools-version: 5.9
import PackageDescription

// VLCKitSPM - Swift Package distribution of the VLCKit (libVLC) build used by the JustFox
// apps (FoxIPTV). This is a MODIFIED build of VLCKit 4.0.0-alpha.20; see README.md for the
// LGPL notice and the corresponding modified source.
//
// Modified source (LGPL-2.1-or-later):
//   VLCKit: https://code.videolan.org/JustFox/VLCKit/-/tree/foxiptv-2.0.1
//   libVLC: https://code.videolan.org/JustFox/vlc/-/tree/foxiptv-2.0.1

let vlcBinary = Target.binaryTarget(
    name: "VLCKit",
    url: "https://github.com/JustFoxLabs/vlckit-spm/releases/download/4.0.0-alpha.20-fox.4/VLCKit.xcframework.zip",
    checksum: "1b97e80f0916b64335d150d081c1a5fb34247a2220cfcca540b57467bbb51330"
)

let package = Package(
    name: "VLCKitSPM",
    platforms: [
        .iOS(.v13)
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
                .linkedFramework("QuartzCore"),
                .linkedFramework("CoreText"),
                .linkedFramework("AVFoundation"),
                .linkedFramework("Security"),
                .linkedFramework("CFNetwork"),
                .linkedFramework("AudioToolbox"),
                .linkedFramework("OpenGLES"),
                .linkedFramework("CoreGraphics"),
                .linkedFramework("VideoToolbox"),
                .linkedFramework("CoreMedia"),
                .linkedLibrary("c++"),
                .linkedLibrary("xml2"),
                .linkedLibrary("z"),
                .linkedLibrary("bz2"),
                .linkedLibrary("iconv")
            ]
        )
    ]
)

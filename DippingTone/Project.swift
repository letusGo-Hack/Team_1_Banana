import ProjectDescription

let project = Project(
    name: "DippingTone",
    targets: [
        .target(
            name: "DippingTone",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.DippingTone",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["DippingTone/Sources/**"],
            resources: ["DippingTone/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "DippingToneTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.DippingToneTests",
            infoPlist: .default,
            sources: ["DippingTone/Tests/**"],
            resources: [],
            dependencies: [.target(name: "DippingTone")]
        ),
    ]
)

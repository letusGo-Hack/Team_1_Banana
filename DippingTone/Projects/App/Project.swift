//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 6/29/24.
//

import ProjectDescription
import DependencyPlugin
import ProjectTemplatePlugin

let infoPlist: [String: Plist.Value] = InfoPlistValues.generateInfoPlist()

let project = Project.makeAppWidgetModule(
    name: Project.Environment.appName,
    bundleId: .mainBundleID(),
    product: .app,
    settings: .appMainSetting,
    scripts: [],
    dependencies: [
                .Shared(implements: .Shareds),
                .Networking(implements: .Networkings),
                .Presentation(implements: .Presentation)
        //
    ],
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    infoPlist: .extendingDefault(with: infoPlist),
        entitlements: .file(path: "../../Entitlements/DippingTone.entitlements")
)

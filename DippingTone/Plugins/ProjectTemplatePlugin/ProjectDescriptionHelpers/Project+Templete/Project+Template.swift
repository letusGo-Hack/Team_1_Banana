//
//  Project+Template.swift
//  MyPlugin
//
//  Created by 서원지 on 1/6/24.
//

import ProjectDescription



public extension Project {
    static func makeAppModule(
        name: String = Environment.appName,
        bundleId: String,
        platform: Platform = .iOS,
        product: Product,
        packages: [Package] = [],
        deploymentTarget: ProjectDescription.DeploymentTargets = Environment.deploymentTarget,
        destinations: ProjectDescription.Destinations = Environment.deploymentDestination,
        settings: ProjectDescription.Settings,
        scripts: [ProjectDescription.TargetScript] = [],
        dependencies: [ProjectDescription.TargetDependency] = [],
        sources: ProjectDescription.SourceFilesList = ["Sources/**"],
        resources: ProjectDescription.ResourceFileElements? = nil,
        infoPlist: ProjectDescription.InfoPlist = .default,
        entitlements: ProjectDescription.Entitlements? = nil,
        schemes: [ProjectDescription.Scheme] = []
    ) -> Project {
        
        
        let appTarget: Target = .target(
            name: name,
            destinations: destinations,
            product: product,
            bundleId: bundleId,
            deploymentTargets: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            entitlements: entitlements,
            scripts: scripts,
            dependencies: dependencies
        )
        
        let appDevTarget: Target = .target(
            name: "\(name)-QA",
            destinations: destinations,
            product: product,
            bundleId: "\(bundleId)",
            deploymentTargets: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            entitlements: entitlements,
            scripts: scripts,
            dependencies: dependencies
        )
        
        let appTestTarget : Target = .target(
            name: "\(name)Tests",
            destinations: destinations,
            product: .unitTests,
            bundleId: "\(bundleId).\(name)Tests",
            deploymentTargets: deploymentTarget,
            infoPlist: .default,
            sources: ["\(name)Tests/Sources/**"],
            dependencies: [.target(name: name)]
        )
        
        let targets = [appTarget, appDevTarget, appTestTarget]
        
        return Project(
            name: name,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes
        )
    }
    
    static func makeAppWidgetModule(
        name: String = Environment.appName,
        bundleId: String,
        platform: Platform = .iOS,
        product: Product,
        packages: [Package] = [],
        deploymentTarget: ProjectDescription.DeploymentTargets = Environment.deploymentTarget,
        destinations: ProjectDescription.Destinations = Environment.deploymentDestination,
        settings: ProjectDescription.Settings,
        scripts: [ProjectDescription.TargetScript] = [],
        dependencies: [ProjectDescription.TargetDependency] = [],
        sources: ProjectDescription.SourceFilesList = ["Sources/**"],
        resources: ProjectDescription.ResourceFileElements? = nil,
        infoPlist: ProjectDescription.InfoPlist = .default,
        entitlements: ProjectDescription.Entitlements? = nil,
        schemes: [ProjectDescription.Scheme] = []
    ) -> Project {
        
        let appTarget: Target = .target(
            name: name,
            destinations: destinations,
            product: product,
            bundleId: bundleId,
            deploymentTargets: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            entitlements: entitlements,
            scripts: scripts,
            dependencies: dependencies + [
                .target(name: "intetnt", condition: .none)
            ],
            buildRules: [
                
            ]
        )
        
        let appDevTarget: Target = .target(
            name: "\(name)-QA",
            destinations: destinations,
            product: product,
            bundleId: "\(bundleId)",
            deploymentTargets: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            entitlements: entitlements,
            scripts: scripts,
            dependencies: dependencies
        )
        
        let appTestTarget: Target = .target(
            name: "\(name)Tests",
            destinations: destinations,
            product: .unitTests,
            bundleId: "\(bundleId).\(name)Tests",
            deploymentTargets: deploymentTarget,
            infoPlist: .default,
            sources: ["\(name)Tests/Sources/**"],
            dependencies: [.target(name: name)]
        )
        
        let intetntTarget: Target = .target(
            name: "intetnt",
            destinations: destinations,
            product: .appExtension,
            bundleId: Environment.bundlePrefix + ".intetnt",
            deploymentTargets: deploymentTarget,
            infoPlist: .extendingDefault(with: [
                "EXAppExtensionAttributes": .dictionary([
                       "EXExtensionPointIdentifier": "com.apple.appintents-extension"
                   ])
            ]),
            sources: ["intetnt/Sources/**"],
            resources: ["intetnt/Resourecs/**"],
            scripts: scripts,
            dependencies: dependencies
        )
        
        // SiriKit target
        let siriKitTarget: Target = .target(
            name: "\(name)SiriKit",
            destinations: destinations,
            product: .appExtension,
            bundleId: "\(bundleId).sirikit",
            deploymentTargets: deploymentTarget,
            infoPlist: .extendingDefault(with: [
                "NSExtension": .dictionary([
                    "NSExtensionPointIdentifier": "com.apple.siri",
                    "NSExtensionPrincipalClass": "$(PRODUCT_MODULE_NAME).IntentHandler"
                ])
            ]),
            sources: ["SiriKit/Sources/**"],
            resources: ["SiriKit/Resources/**"],
            dependencies: []
        )
        
        let targets = [appTarget, appDevTarget, appTestTarget, intetntTarget, siriKitTarget]
        
        return Project(
            name: name,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes
        )
    }

}



extension Scheme {
    public static func makeScheme(target: ConfigurationName, name: String) -> Scheme {
        return Scheme.scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: target,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
            ),
            runAction: .runAction(configuration: target),
            archiveAction: .archiveAction(configuration: target),
            profileAction: .profileAction(configuration: target),
            analyzeAction: .analyzeAction(configuration: target)
            
        )
        
    }
    
}

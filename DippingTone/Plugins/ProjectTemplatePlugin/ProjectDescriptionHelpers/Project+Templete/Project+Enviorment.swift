//
//  Project+Enviorment.swift
//  MyPlugin
//
//  Created by 서원지 on 1/6/24.
//

import Foundation
import ProjectDescription

public extension Project {
    enum Environment {
        public static let appName = "DippingTone"
        public static let appDemoName = "DippingTone-Demo"
        public static let appDevName = "DippingTone-Dev"
        public static let deploymentTarget : ProjectDescription.DeploymentTargets = .iOS("18.0")
        public static let deploymentDestination: ProjectDescription.Destinations = [.iPhone]
        public static let organizationTeamId = "N94CS4N6VR"
        public static let bundlePrefix = "io.DippingTone.DippingTone"
        public static let appVersion = "1.0.0"
        public static let mainBundleId = "io.DippingTone.DippingTone"
    }
}

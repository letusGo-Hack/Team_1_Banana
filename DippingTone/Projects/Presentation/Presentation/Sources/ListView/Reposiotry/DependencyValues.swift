//
//  DependencyValues.swift
//  Presentation
//
//  Created by 서원지 on 6/29/24.
//

import SwiftData
import Dependencies
import Model

struct Database {
    var context: () throws -> ModelContext
}

extension Database: @preconcurrency DependencyKey {
    @MainActor
    public static let liveValue = Self(
        context: { appContext }
    )
}

@MainActor
let appContext: ModelContext = {
    let container = SwiftDataModelConfigurationProvider.shared.container
    let context = ModelContext(container)
    return context
}()


extension DependencyValues {
    var databaseService: Database {
        get { self[Database.self] }
        set { self[Database.self] = newValue }
    }
}

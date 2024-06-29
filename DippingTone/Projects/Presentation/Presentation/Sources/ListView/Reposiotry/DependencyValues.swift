//
//  DependencyValues.swift
//  Presentation
//
//  Created by 서원지 on 6/29/24.
//

import SwiftData
import Dependencies
import Model
import ComposableArchitecture
import SwiftUI

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


public extension DependencyValues {
    var workoutDatabase: LIstModelDatabase {
        get { self[LIstModelDatabase.self] }
        set { self[LIstModelDatabase.self] = newValue }
    }
}

public struct LIstModelDatabase {
    public var fetchAll: @Sendable () throws -> [LIstModel]
    public var fetch: @Sendable (FetchDescriptor<LIstModel>) throws -> [LIstModel]
    public var add: @Sendable (LIstModel) throws -> Void
    public var delete: @Sendable (LIstModel) throws -> Void
    public var save: @Sendable () throws -> Void
    public var deleteall: @Sendable () throws -> Void
    
    enum WorkoutError: Error {
        case add
        case delete
        case save
    }
}

extension LIstModelDatabase: DependencyKey {
    public static let liveValue = Self(
        fetchAll: {
            do {
                @Dependency(\.databaseService.context) var context
                let ListModelContext = try context()
                
                let descriptor = FetchDescriptor<LIstModel>()
                return try ListModelContext.fetch(descriptor)
            } catch {
                return []
            }
            
        }, fetch: { descriptor in
            do {
                @Dependency(\.databaseService.context) var context
                let ListModelContext = try context()
                return try ListModelContext.fetch(descriptor)
            } catch {
                return []
            }
        }, add: { model in
            do {
                @Dependency(\.databaseService.context) var context
                let ListModelContext = try context()
                
                ListModelContext.insert(model)
            } catch {
                throw CustomError.add
            }
        }, delete: { model in
            do {
                @Dependency(\.databaseService.context) var context
                let ListModelContext = try context()
                
                let ListModeToBeDelete = model
                ListModelContext.delete(ListModeToBeDelete)
            } catch {
                throw CustomError.delete
            }
        }, save: {
            do {
                @Dependency(\.databaseService.context) var context
                let ListModelContext = try context()
                
                try ListModelContext.save() // Save changes to the database
            } catch {
                throw CustomError.add
            }
        }, deleteall: { 
            do {
                @Dependency(\.databaseService.context) var context
                let ListModelContext = try context()
                
                let fetchRequest = FetchDescriptor<LIstModel>()
                let allItems = try ListModelContext.fetch(fetchRequest)
                
                for item in allItems {
                    ListModelContext.delete(item)
                }
                
                try ListModelContext.save() // 변경 사항 저장
            } catch {
                throw CustomError.delete
            }
        }
    )
}

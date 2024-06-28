//
//  AppDIContainer.swift
//  DippingTone
//
//  Created by 서원지 on 6/29/24.
//

import Foundation
import Networkings
import DiContainer

public final class AppDIContainer {
    public static let shared: AppDIContainer = .init()

    private let diContainer: DependencyContainer = .live
    
    private init() {
    }

    public func registerDependencies() async {
        await registerRepositories()
        await registerUseCases()
    }
    
    // MARK: - Use Cases
    private func registerUseCases() async {
        
    }
    
//    private func registerAuthUseCase() async {
//        await diContainer.register(AuthUseCaseProtocol.self) {
//            guard let repository =  self.diContainer.resolve(AuthRepositoryProtocol.self) else {
//                assertionFailure("AuthRepositoryProtocol must be registered before registering AuthUseCaseProtocol")
//                return AuthUseCase(repository: DefaultAuthRepository())
//            }
//            return AuthUseCase(repository: repository)
//        }
//    }
    
    // MARK: - Repositories Registration
    private func registerRepositories() async {
        
    }
    
//    private func registerAuthRepositories() async {
//        await diContainer.register(AuthRepositoryProtocol.self) {
//            AuthRepository()
//        }
//    }
}


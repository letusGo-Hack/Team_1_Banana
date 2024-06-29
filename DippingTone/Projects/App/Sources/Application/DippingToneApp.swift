import SwiftUI
import Presentation
import ComposableArchitecture
import Model

@main
struct DippingToneApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        registerDependencies()
    }
    
    
    var body: some Scene {
        WindowGroup {
            ListVIew(store: Store(initialState: ListFeature.State(), reducer: {
                ListFeature()
                    ._printChanges()
            }))
            .modelContainer(SwiftDataModelConfigurationProvider.shared.container)
        
        }
    }
    
    private func registerDependencies() {
        Task {
            await AppDIContainer.shared.registerDependencies()
        }
    }
}

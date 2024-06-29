import SwiftUI

@main
struct DippingToneApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        registerDependencies()
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        
        }
    }
    
    private func registerDependencies() {
        Task {
            await AppDIContainer.shared.registerDependencies()
        }
    }
}

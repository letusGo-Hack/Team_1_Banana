import SwiftUI
import DesignSystem

public struct ContentView: View {
    public init() {}

    public var body: some View {
        ZStack {
            Color.red
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("hi")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

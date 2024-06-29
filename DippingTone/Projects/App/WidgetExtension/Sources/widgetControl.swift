//
//  widgetControl.swift
//  WidgetExtension
//
//  Created by 안정흠 on 6/29/24.
//

import AppIntents
import SwiftUI
import WidgetKit
import ComposableArchitecture
import Presentation

public struct widgetControl: ControlWidget {
    public init() {
        
    }
//    @Bindable var store: StoreOf<ListFeature>
//    
//    public init(store: StoreOf<ListFeature>) {
//        self.store = store
//    }
    
    static let kind: String = "io.DippingTone.DippingTone"
    
    public var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(kind: Self.kind) {
            ControlWidgetButton(action: LaunchAppIntent()) {
                VStack {
                
                    Image(systemName: "pencil.line")
                    Text("😀").font(.title)
                    Text("I am so happy").font(.body)
                }
            }
        }
    }
}

struct LaunchAppIntent: AppIntent {
    static var title: LocalizedStringResource { "Open App" }
    @Environment(\.openURL) var openURL

    init() {}

    func perform() async throws -> some IntentResult {
        if let url = URL(string: "myapp://") { //myapp://open
            DispatchQueue.main.async {
                openURL(url)
            }
        }
        return .result()
    }
}

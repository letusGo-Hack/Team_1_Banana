//
//  widgetControl.swift
//  widget
//
//  Created by 안정흠 on 6/29/24.
//

import AppIntents
import SwiftUI
import WidgetKit
import Presentation
import ComposableArchitecture
import Networkings
import Model
import SwiftData

struct widgetControl: ControlWidget {
    static let kind: String = "io.DippingTone.DippingTone"
    @Environment(\.modelContext) var context
    
    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(kind: Self.kind) {
            ControlWidgetButton(action: LaunchAppIntent()) {
                VStack {
                    Image(systemName: "pencil.line")
                    Text(fetchRecentlyData()).font(.title)
//                    Text("").font(.body)
                }
            }
        }
    }
}

extension widgetControl {
    func fetchRecentlyData() -> String {
        do {
            let descriptor = FetchDescriptor<LIstModel>()
            let temp = try context.fetch(descriptor) 
            
            return temp.first!.title!
        } catch {
            return ""
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

//
//  intent.swift
//  intent
//
//  Created by 서원지 on 6/29/24.
//

import AppIntents

struct intent: AppIntent {
    static var title: LocalizedStringResource { "intent" }
    
    func perform() async throws -> some IntentResult {
        return .result()
    }
}

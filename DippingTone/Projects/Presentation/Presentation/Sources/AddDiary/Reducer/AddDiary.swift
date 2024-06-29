//
//  AddDiary.swift
//  Presentation
//
//  Created by 서원지 on 6/29/24.
//

import Foundation
import ComposableArchitecture
import Model
import NaturalLanguage

@Reducer
public struct AddDiary {
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
        var addText: String = ""
        var scoreText: String = ""
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case addItem(addDiaryItem: String)
        case processSentance(text: String)
        
    }
    
    @Dependency(LIstModelDatabase.self) var context
    
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            
            case let .processSentance(text):
                let tagger = NLTagger(tagSchemes: [.sentimentScore])
                tagger.string = text
                let sentiment = tagger.tag(at: text.startIndex, unit: .paragraph, scheme: .sentimentScore).0
                let score = Double(sentiment?.rawValue ?? "0") ?? 0
                state.scoreText = "\(score)"
                
                switch score {
                case let value where value > 0.0:
                    state.scoreText = "😀" 
                case let value where value > -0.5:
                    state.scoreText = "😐"
                case let value where value > -1.0:
                    state.scoreText = "🙁"
                default:
                    state.scoreText = "🥱"
                }
                return .none
                
            case let .addItem(addDiaryItem: addDiaryItem):
                do {
                    try context.add(.init(createTime: Date.now, editime: Date.now, title: addDiaryItem))
                } catch {
                    
                }
                return .none
                
            case .binding(_):
                return .none
            }
        }
    }
}


//
//  Root.swift
//  Presentation
//
//  Created by 서원지 on 6/29/24.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct Root {
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
        var path: StackState<Path.State> = .init()
    }
    
    public enum Action {
        case path(StackAction<Path.State, Path.Action>)
        case appear
        case removePath
    }
    
    
    @Reducer(state: .equatable)
    public enum Path {
        case listDiary(ListFeature)
        case editDIary(Edit)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .appear:
                state.path.append(.listDiary(.init()))
                return .none
                
            case .removePath:
                state.path.removeLast()
                return .none
                
            case let .path(action):
                switch action {
                case .element(id: _, action: .listDiary(.view(.editDiary))):
                    state.path.append(.editDIary(.init()))
                    
                default:
                    break
                }
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}


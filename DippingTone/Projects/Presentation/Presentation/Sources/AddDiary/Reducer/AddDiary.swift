//
//  AddDiary.swift
//  Presentation
//
//  Created by 서원지 on 6/29/24.
//

import Foundation
import ComposableArchitecture
import Model

@Reducer
public struct AddDiary {
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
        var addText: String = ""
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case addItem(addDiaryItem: String)
        
    }
    
    @Dependency(LIstModelDatabase.self) var context
    
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            
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


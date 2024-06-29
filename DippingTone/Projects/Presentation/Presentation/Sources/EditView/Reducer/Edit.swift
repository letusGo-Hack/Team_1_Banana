//
//  Edit.swift
//  Presentation
//
//  Created by 서원지 on 6/29/24.
//

import Foundation
import ComposableArchitecture
import Model
import SwiftData

@Reducer
public struct Edit {
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
        var lisModel: [LIstModel] = []
        var isEditing: Bool = false
        var offset: CGFloat = 0
        var selectModel: LIstModel? = nil
        var deleteImage: String = "minus.circle"
        var fetchDescriptor: FetchDescriptor<LIstModel> {
            return .init()
        }
        
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case fetchList
        case deleteItem(model: LIstModel)
    }
    
    @Dependency(LIstModelDatabase.self) var context
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .fetchList:
                do {
                    state.lisModel = try context.fetch(state.fetchDescriptor)
                } catch { }
                return .none
                
            case let .deleteItem(model):
                do {
                    try context.delete(model)
                    state.lisModel.removeAll { $0 == model }
                    state.lisModel = try context.fetch(state.fetchDescriptor)
                } catch {
//                    state.errorMessage = "Failed to delete item."
                }
                return .none
                
            case .binding(_):
                return .none
            }
        }
    }
}


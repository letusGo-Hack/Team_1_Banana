//
//  List.swift
//  Presentation
//
//  Created by 서원지 on 6/29/24.
//

import Foundation
import ComposableArchitecture
import Model

@Reducer
public struct List {
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
        
        var lisModel: [LIstModel] = []
        var errorMessage: String = ""
    }
    
    public enum Action {
        case updateModel(Result<[LIstModel], CustomError>)
        
        case view(View)
        
        
        public enum View {
            
        }
    }
    
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
                
            case let .updateModel(data):
                switch data {
                case .success(let data):
                    state.lisModel = data
                case .failure(let error):
                    state.errorMessage = error.localizedDescription
                }
                return .none
            }
        }
    }
}


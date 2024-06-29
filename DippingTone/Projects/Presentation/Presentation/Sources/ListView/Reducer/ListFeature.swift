//
//  List.swift
//  Presentation
//
//  Created by 서원지 on 6/29/24.
//

import Foundation
import ComposableArchitecture
import Model
import SwiftData

@Reducer
public struct ListFeature {
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
        
        var lisModel: [LIstModel] = []
        var errorMessage: String = ""
        var addItemImage: String = "plus"
        var fetchDescriptor: FetchDescriptor<LIstModel> {
            return .init()
        }
        
        @Presents var destination: Destination.State?
    }
    
    public enum Action : BindableAction{
        case binding(BindingAction<State>)
        case updateModel(Result<[LIstModel], CustomError>)
        case fetchList
        case view(View)
        case addList
        case delete(LIstModel)
        case deleteAll
        case destination(PresentationAction<Destination.Action>)
        case closeModal
        
        public enum View {
            case addDiary
        }
    }
    
    @Reducer(state: .equatable)
    public enum  Destination {
        case addDiary(AddDiary)
    }
    
    
    @Dependency(LIstModelDatabase.self) var context
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .addList:
                do {
                    let testDiary = "let's us go 찍먹톤"
                    try context.add(.init(createTime: Date.now, editime: Date.now, title: testDiary))
                } catch {
                    
                }
                
                return .run { send in
                    await send(.fetchList)
                }
                
                
            case let .delete(model):
                do {
                    try context.delete(model)
                    state.lisModel.removeAll { $0 == model }
                    state.lisModel = try context.fetch(state.fetchDescriptor)
                } catch {
                    state.errorMessage = "Failed to delete item."
                }
                
                return .none
//            case .add:
////                context.add(.init(title: "test11111"))
//                return .none
                
                
            case .destination(_):
                return .none
                
            case .closeModal:
                state.destination = nil
                return .run { send in
                    await send(.fetchList)
                }
                
            case .deleteAll:
                do {
                    try context.deleteall() // 모든 항목을 삭제하는 메서드 호출
                    state.lisModel.removeAll() // 상태에서도 모든 항목을 제거
                } catch {
                    state.errorMessage = "Failed to delete all items."
                }
                return .none
            case .fetchList:
                do {
                    state.lisModel = try context.fetch(state.fetchDescriptor)
                } catch { }
                return .none
            case let .updateModel(data):
                switch data {
                case .success(let data):
                    state.lisModel = data
                case .failure(let error):
                    state.errorMessage = error.localizedDescription
                }
                return .none
                
                
                
            case .binding(_):
                return .none
            case .view(.addDiary):
                state.destination = .addDiary(.init())
                return .none
                
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}


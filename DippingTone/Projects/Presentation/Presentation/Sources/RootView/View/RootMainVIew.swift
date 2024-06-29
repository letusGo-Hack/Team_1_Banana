//
//  RootMainVIew.swift
//  Presentation
//
//  Created by 서원지 on 6/29/24.
//

import SwiftUI
import ComposableArchitecture


public struct RootMainVIew: View {
    @Bindable var store: StoreOf<Root>
    
    public init(
        store: StoreOf<Root>
    ) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            ListVIew(store: Store(initialState: ListFeature.State(), reducer: {
                ListFeature()
            }))
        } destination: { switchStore in
            switch switchStore.case {
            case let .listDiary(listStore):
                ListVIew(store: listStore)
                    .navigationBarBackButtonHidden()
                
            case let .editDIary(editStore):
                EditView(store: editStore, backAction: {
                    store.send(.removePath)
                })
                    .navigationBarBackButtonHidden()
                
            }
        }
        .task {
            store.send(.appear)
        }

    }
}


//
//  ListVIew.swift
//  Presentation
//
//  Created by 서원지 on 6/29/24.
//

import SwiftUI
import ComposableArchitecture
import Translation
import DesignSystem

public struct ListVIew: View {
    @Bindable var store: StoreOf<ListFeature>
    
    
    public init(
        store: StoreOf<ListFeature>
    ) {
        self.store = store
    }
    
    public var body: some View {
        ZStack {
            Color.basicBlackDimmed
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                navigationBar()
                
                titleView()
                
                listDiaryView()
                
                Spacer()
            }
            .task {
            
                store.send(.fetchList)
            }
            
        }
        .sheet(item: $store.scope(state: \.destination?.addDiary, action: \.destination.addDiary)) { addDiaryStore in
            AddDiaryView(store: addDiaryStore, closeModelAction: {
                store.send(.closeModal)
            })
                .presentationDetents([.height(UIScreen.screenHeight * 0.4)])
                .presentationCornerRadius(20)
                .presentationDragIndicator(.hidden)
                .presentationBackground(Color.basicBlackDimmed)
        }
    }
}


extension ListVIew {
    
    @ViewBuilder
    private func navigationBar() -> some View {
        VStack {
            Spacer()
                .frame(height: UIScreen.screenHeight * 0.02)
            
            HStack {
                Image(systemName: store.editItemImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        store.send(.view(.editDiary))
                    }
                
                Spacer()
                
                Image(systemName: store.addItemImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        store.send(.view(.addDiary))
                    }
                
            }
            .padding(.horizontal, 20)
            
        }
    }
    
    @ViewBuilder
    private func titleView() -> some View {
        VStack {
            Spacer()
                .frame(height: UIScreen.screenHeight * 0.01)
            
            HStack {
                Text("오늘 쓴 한줄 일기")
                    .pretendardFont(family: .SemiBold, size: 30)
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
    
    @ViewBuilder
    private func listDiaryView() -> some View {
        VStack {
            
            ForEach(store.lisModel, id: \.self) { item in
//
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.basicWhite, style: .init(lineWidth: 1))
                    .frame(height: 48)
                    .padding(.horizontal, 20)
                    .overlay {
                        HStack {
                            Spacer()
                                .frame(width: 10)
                            
                            Text(item.title ?? "")
                                .pretendardFont(family: .SemiBold, size: 18)
                                .foregroundColor(Color.basicWhite)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                       
                    }
                
                Spacer()
                    .frame(height: 15)
                
            }
        }
    }
    
}

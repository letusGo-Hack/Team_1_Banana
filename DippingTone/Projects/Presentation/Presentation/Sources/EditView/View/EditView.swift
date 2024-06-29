//
//  EditView.swift
//  Presentation
//
//  Created by 서원지 on 6/29/24.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem


public struct EditView: View {
    @Bindable var store: StoreOf<Edit>
    var backAction: () -> Void
    
    public init(
        store: StoreOf<Edit>,
        backAction: @escaping () -> Void
    ) {
        self.store = store
        self.backAction = backAction
    }
    
    public var body: some View {
        ZStack {
            Color.basicBlackDimmed
                .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                Spacer()
                    .frame(height: UIScreen.screenHeight * 0.01)
                
                NavigationBackButton(buttonAction: backAction)
                
                editTItleView()
                
                Spacer()
                    .frame(height: 20)
                
                editLIstView()
                
                Spacer()
            }
        }
        .task {
            store.send(.fetchList)
        }
        .onTapGesture {
            store.isEditing.toggle()
        }
    }
}

extension EditView {
    
    @ViewBuilder
    private func editTItleView() -> some View {
        VStack {
            Spacer()
                .frame(height: UIScreen.screenHeight * 0.02)
            
            HStack {
                Text("일기 수정")
                    .pretendardFont(family: .SemiBold, size: 40)
                    .foregroundColor(Color.basicWhite)
                Spacer()
                
            }
            .padding(.horizontal, 20)
            
        }
        
    }
    
    @ViewBuilder
    private func editLIstView() -> some View {
        VStack {
            
            ForEach(store.lisModel, id: \.self) { item in
//
                HStack {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.basicWhite, style: .init(lineWidth: 1))
                        .frame(height: 60)
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
                        .offset(x: item == store.selectModel && store.isEditing ? -20 : 0)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    withAnimation(.easeOut) {
                                        if gesture.translation.width < -40 {
                                            self.store.offset = gesture.translation.width
                                        }
                                    }
                                }
                                .onEnded { _ in
                                    withAnimation(.spring()) {
                                        if self.store.offset < -40 {
                                            self.store.selectModel = item
                                            self.store.isEditing = true
                                        }
                                        self.store.offset = 0
                                    }
                                }
                        )
                    
                    if store.isEditing && item == store.selectModel {
                        VStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.statusWarning)
                                .frame(width: 80, height: 60)
                                .offset(x: -10)
                                .overlay {
                                    HStack {
                                        Spacer()
                                            .frame(width: 12)
                                        
                                        Image(systemName: store.deleteImage)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                            .onTapGesture {
                                                store.send(.deleteItem(model: item))
                                                
                                                store.isEditing = false
                                            }
                                            .offset(x: -10)
                                        
                                        Spacer()
                                            .frame(width: 12)
                                    }
                                }
                        }
                        
                        Spacer()
                            .frame(width: 20)
                    }
                }
                
                
                Spacer()
                    .frame(height: 15)
                
            }
            .animation(.smooth, value: store.isEditing)
        }
    }
}

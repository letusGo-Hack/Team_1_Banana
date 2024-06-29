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

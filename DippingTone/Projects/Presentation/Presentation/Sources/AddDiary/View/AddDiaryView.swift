//
//  AddDiaryView.swift
//  Presentation
//
//  Created by 서원지 on 6/29/24.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem
import Utill
import Translation

public struct AddDiaryView: View {
    @Bindable var store: StoreOf<AddDiary>
    var closeModelAction: () -> Void
    
    public init(
        store: StoreOf<AddDiary>,
        closeModelAction: @escaping () -> Void
        
    ) {
        self.store = store
        self.closeModelAction = closeModelAction
    }
    
    public var body: some View {
        ZStack {
            Color.basicBlackDimmed
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack {
                    
                    Spacer()
                        .frame(height: UIScreen.screenHeight * 0.04)
                    
                    addDiaryItem()
                    
                    Spacer()
                        .frame(height: UIScreen.screenHeight * 0.2)
                    
                    addDiaryButton()
                    
                    Spacer()
                }
            }
            .bounce(false)
//            .translationPresentation(isPresented: .constant(true), text: $store.addText, attachmentAnchor: .point(.bottom))
        }
    }
}

extension AddDiaryView {
    
    @ViewBuilder
    private func addDiaryItem() -> some View {
        VStack {
            TextField("오늘 쓸 일기를에 대한 내용을 추가 해주세요", text: $store.addText)
                .lineLimit(1)
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func addDiaryButton() -> some View {
        VStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.basicBlue200.opacity(0.4))
                .frame(height: 48)
                .padding(.horizontal, 20)
                .overlay {
                    Text("일기를 추가해주세요")
                        .pretendardFont(family: .SemiBold, size: 16)
                        .foregroundColor(Color.basicWhite)
                }
                .onTapGesture {
                    store.send(.addItem(addDiaryItem: store.addText))
                    
                    Task {
                        await Task.sleep(1)
                        
                        closeModelAction()
                    }
                    
                }
        }
        
        
    }
}

//
//  ListVIew.swift
//  Presentation
//
//  Created by 서원지 on 6/29/24.
//

import SwiftUI
import ComposableArchitecture

public struct ListVIew: View {
    @Bindable var store: StoreOf<List>
    
    
    public init(
        store: StoreOf<List>
    ) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            
        }
    }
}


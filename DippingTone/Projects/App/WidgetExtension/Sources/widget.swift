//
//  widget.swift
//  WidgetExtension
//
//  Created by 안정흠 on 6/29/24.
//

import WidgetKit
import SwiftUI
import ComposableArchitecture
import Presentation

@main
struct widget: WidgetBundle {
    var body: some Widget {
        widgetControl(store: Store(initialState: ListFeature.State(), reducer: {
            ListFeature()
        }))
    }
}

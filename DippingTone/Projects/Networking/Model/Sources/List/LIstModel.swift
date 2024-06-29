//
//  LIstModel.swift
//  Model
//
//  Created by 서원지 on 6/29/24.
//

import SwiftData
import SwiftUI

@Model
public class LIstModel: Identifiable{
 
    var createTime: Date?
    var editime: Date?
    var title: String?
        
    public init(
        createTime: Date? = nil,
        editime: Date? = nil,
        title: String? = nil) {
        self.createTime = createTime
        self.editime = editime
        self.title = title
    }
}

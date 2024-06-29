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
 
    public var createTime: Date?
    public var editime: Date?
    public var title: String?
        
    public init(
        createTime: Date? = nil,
        editime: Date? = nil,
        title: String? = nil) {
        self.createTime = createTime
        self.editime = editime
        self.title = title
    }
}

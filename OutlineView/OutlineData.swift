//
//  OutlineData.swift
//  OutlineView
//
//  Created by Toph Allen on 4/13/20.
//  Copyright © 2020 Toph Allen. All rights reserved.
//

import Foundation

class OutlineData {
    let name: String
    var children: [OutlineData]
    
    init(name: String) {
        self.name = name
        self.children = []
    }
    
    init(name: String, children: [OutlineData]) {
        self.name = name
        self.children = children
    }
    
    class func rootItem() -> OutlineData {
        let i11 = OutlineData(name: "Item 1.1")
        let i12 = OutlineData(name: "Item 1.2")
        let i13 = OutlineData(name: "Item 1.3")
        let i1 = OutlineData(name: "Item 1", children: [i11, i12, i13])
        
        let i221 = OutlineData(name: "Item 2.2.1")
        let i222 = OutlineData(name: "Item 2.2.2")
        let i223 = OutlineData(name: "Item 2.2.3")
        
        let i21 = OutlineData(name: "Item 2.1")
        let i22 = OutlineData(name: "Item 2.2", children: [i221, i222, i223])
        let i23 = OutlineData(name: "Item 2.3")
        
        let i2 = OutlineData(name: "Item 2", children: [i21, i22, i23])
        
        let i31 = OutlineData(name: "Item 3.1")
        let i32 = OutlineData(name: "Item 3.2")
        let i33 = OutlineData(name: "Item 3.3")
        let i3 = OutlineData(name: "Item 3", children: [i31, i32, i33])
        
        let root = OutlineData(name: "Root", children: [i1, i2, i3])
        return root
    }
}




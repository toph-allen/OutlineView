//
//  OutlineData.swift
//  OutlineView
//
//  Created by Toph Allen on 4/13/20.
//  Copyright © 2020 Toph Allen. All rights reserved.
//

import Foundation


// I could add an isRoot variable...
class OutlineData: ObservableObject, Identifiable, Hashable {
    var id: UUID = UUID()
    let name: String
    var children: [OutlineData]
    @Published var open: Bool
    var isRoot: Bool
    
    
    init(name: String) {
        self.name = name
        self.children = []
        self.open = false
        self.isRoot = false
    }
    
    init(name: String, children: [OutlineData]) {
        self.name = name
        self.children = children
        self.open = false
        self.isRoot = false
    }
    
    init(name: String, children: [OutlineData], isRoot: Bool) {
        self.name = name
        self.children = children
        self.isRoot = isRoot
        self.open = self.isRoot
    }
    
    static func == (lhs: OutlineData, rhs: OutlineData) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    class func getRoot() -> OutlineData {
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
        
        let i421 = OutlineData(name: "Item 4.2.1")
        let i422 = OutlineData(name: "Item 4.2.2")
        let i423 = OutlineData(name: "Item 4.2.3")
        let i424 = OutlineData(name: "Item 4.2.4")
        let i425 = OutlineData(name: "Item 4.2.5")
        let i426 = OutlineData(name: "Item 4.2.6")
        let i427 = OutlineData(name: "Item 4.2.7")
        let i428 = OutlineData(name: "Item 4.2.8")
        
        let i441 = OutlineData(name: "Item 4.4.1")
        let i442 = OutlineData(name: "Item 4.4.2")
        let i443 = OutlineData(name: "Item 4.4.3")
        let i444 = OutlineData(name: "Item 4.4.3")
        
        let i41 = OutlineData(name: "Item 4.1")
        let i42 = OutlineData(name: "Item 4.2", children: [i421, i422, i423, i424, i425, i426, i427, i428])
        let i43 = OutlineData(name: "Item 4.3")
        let i44 = OutlineData(name: "Item 4.4", children: [i441, i442, i443, i444])
        
        let i4 = OutlineData(name: "Item 4", children: [i41, i42, i43, i44])
        
        let root = OutlineData(name: "Root", children: [i1, i2, i3, i4], isRoot: true)
        return root
    }
}
